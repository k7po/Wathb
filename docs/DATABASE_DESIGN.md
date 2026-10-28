# WATHB — تصميم قاعدة البيانات الأولي

> **حالة المخطط:** هذا تصميم مقترح فقط؛ لم تُنشأ migrations ولم يُطبّق أو يُختبر على قاعدة بيانات. يجب تفعيل RLS/grants لكل جدول أو عرض مكشوف عبر API.

## نموذج الكيانات والحالات

- `profiles(id=auth.users.id, display_name, avatar_path, timezone, visibility, …)`؛ بيانات الاتصال خاصة. `sports(id, translation_key, active)`, `positions(id, sport_id, translation_key)`, `player_sports(user_id,sport_id, optional level/source)`؛ جدول `player_sport_positions(user_id,sport_id,position_id)` يربط المراكز بقيد أجنبي مركب إلى رياضة اللاعب وقاموس مراكز الرياضة. لا مستوى موثوق بلا مصدر.
- `friendships(user_low,user_high,requested_by,status,created_at,updated_at)` زوج مستخدمين مرتب وفريد وحالاته `pending/accepted/declined` فقط؛ انتقالاته عبر RPC. الحظر كيان منفصل اتجاهي `blocks(blocker_id,blocked_id,created_at)` بمفتاح مركب ومنع حظر الذات؛ لا يمثل الحظر حالة صداقة ولا يغيّر سجل العلاقة.
- `venues(id,name,address,lat/lon,verification_source,status)`؛ قراءة المنشور، تعديل إداري موثق. `venue_reviews(id, venue_id, activity_id, reviewer_id, rating, body, status)` فريد للمراجع/الزيارة المستوفية.
- `activity_series(id,owner_id,sport_id,rule,timezone,ends_at,status)`؛ `matches(id,series_id,occurrence_key,owner_id,sport_id,starts_at,timezone,venue_id/location_text,capacity,status,details,...)`. `occurrence_key` فريد داخل السلسلة. تظل كل نسخة مستقلة؛ قاعدة تكرار محدودة وتولد أفقًا قريبًا لا نسخًا لا نهائية.
- `match_participants(match_id,user_id,response_status,invited_by,invited_at,responded_at,attendance_status,attendance_by,attendance_at)` PK مركب؛ `response_status` إحدى `invited/accepted/declined/withdrawn`، و`attendance_status` مستقل nullable أو `attended/no_show`. صف واحد للدعوة والعضوية، لا جدول دعوات مكرر. القبول يحجز المقعد، أما الحضور/الغياب فيسجله المنظم بعد الموعد ولا يطمس جواب الدعوة. `no_show` لا يسجل إلا لمقبول وفق قرار سياسة الحضور.
- `match_comments(id,match_id,author_id,body,visibility,status,created_at,updated_at)`؛ تحرير الكاتب ضمن مهلة وسياسة، حذف/إخفاء moderation مدقق، الإبلاغ مرتبط بمعرف تعليق. لا رسائل خاصة.
- `team_sets(id,match_id,revision,method,seed,algorithm_version,created_by,status)`؛ حالات `draft/active/superseded` مع مراجعة نشطة واحدة لكل نشاط. و`teams(id,team_set_id,match_id,name,position)`؛ و`team_members(team_id,team_set_id,match_id,user_id,assigned_by,locked)`. مفاتيح أجنبية مركبة تضمن انتماء الفريق/العضو للنشاط نفسه، وunique `(team_set_id,user_id)` يمنع تكرار اللاعب داخل المراجعة دون منع حفظ تاريخ التشكيلات. لا تُضاف إلا عضوية مشارك مؤهل وفق قواعد النشاط.
- `match_results(match_id,revision,entered_by,payload,status,confirmed_by,confirmed_at,disputed_at)` بمفتاح مركب `(match_id,revision)` وحالات `draft/submitted/confirmed/disputed/superseded`. النتيجة مرنة حسب الرياضة ومخطط إصدار؛ التصحيح ينشئ revision جديدة ويحوّل القديمة إلى `superseded`، فلا توجد حالة `corrected` ملتبسة أو كتابة صامتة فوق نتيجة سابقة.
- `player_reviews(match_id,reviewer_id,reviewee_id,rating,body,status,created_at)` unique ثلاثي، منع الذات، أهلية حضور الطرفين وتوقيت ونشر عبر دالة. البلاغات/moderation تحفظ الحالة والقرار والمدقق.
- `notifications(id,user_id,type,entity_type,entity_id,idempotency_key,read_at,created_at)` سجل صندوق in-app فريد لمصدر الحدث/المستلم. `notification_preferences(user_id,type,in_app,push,quiet_hours,timezone)` للتفضيلات. `notification_deliveries(notification_id,channel,scheduled_at,delivery_state,attempts,sent_at)` outbox للقنوات المجدولة، فريد للإشعار والقناة وقابل لإعادة المحاولة. `reports(id,reporter_id,target_type,target_id,reason,status,decision_by,decided_at)` صلاحيات محدودة.
- تسجل `match_audit_events` أو آلية تدقيق موحدة تغييرات الحضور والنتائج والإشراف والفرق، مع تقليل PII؛ يحتفظ `team_sets` بتاريخ مراجعات التشكيل.

## القيود والفهارس

- PK UUID/FKs موثقة، `CHECK capacity > 0`, rating ضمن المقياس المعتمد، status ضمن enum/check، `starts_at` مع timezone، لا self-friend/self-review/self-block. يضمن FK لمركز اللاعب تطابق الرياضة، ومفاتيح team set المركبة تطابق النشاط.
- فهارس: matches على `(status, starts_at)`, `(owner_id, starts_at DESC)`, `(sport_id, starts_at)`؛ المشاركون `(user_id,response_status,match_id)` و`(match_id,response_status,attendance_status)`؛ سلسلة/occurrence unique؛ comments `(match_id,created_at)`؛ team sets unique `(match_id,revision)` وفهرس جزئي لمراجعة نشطة واحدة، teams `(team_set_id,position)`، team members unique `(team_set_id,user_id)`؛ notifications `(user_id,created_at DESC)` وunique idempotency؛ reviews على target/time والحالة. أضف فهارس FK المستخدمة، وفهرس مكاني فقط بعد اختيار استعلام/مزود جغرافي.
- المشاركون ذوو `response_status=accepted` لا يتجاوزون السعة؛ حضور `attended` لا يحجز مقعدًا إضافيًا ولا يغيّر الرد. الفحص داخل transaction بقفل صف المباراة/قفل advisory مضبوط؛ لا يعتمد count دون قفل عند آخر مقعد. قرار تغيير السعة بعد القبول وقائمة الانتظار مفتوح ويحسم قبل P4.

## RPC والمعاملات

`create_match(...)` ينشئ النشاط والدعوات المطلوبة؛ `respond_to_invitation(match_id,response)` يغير `response_status` فقط، وهو idempotent، ويتحقق من الدعوة ويقفل النشاط ويفحص السعة؛ عدد المقاعد المحجوزة يساوي المشاركين ذوي `response_status=accepted`، حتى بعد تسجيل الحضور. `update_or_cancel_match` يحقق المنظم ويقفل النسخ المتأثرة ويكتب الإشعارات؛ `generate_teams(match_id,method,seed,locks)` ينشئ مراجعة تشكيل كاملة ويجعلها نشطة ذريًا؛ `record_attendance` المنظم يسجل `attendance_status` مستقلًا مع مصدر ووقت وإمكانية اعتراض؛ `submit/confirm/dispute/correct_result` تنشئ/تحدّث revisions وصلاحياتها؛ `create_review` يتحقق من الحضور/زيارة الملعب المؤهلة والنافذة والتكرار؛ `delete_account` يحذف/يجهّل مع إبطال الجلسة والسياسة. التعليقات كيان مستقل في `match_comments` وليست حقلًا أو استجابة دعوة.

كل دالة `SECURITY DEFINER` عند الضرورة فقط، `search_path` ثابت، grants محددة، والتحقق من `auth.uid()` داخلها. إشعار DB داخل المعاملة أو outbox خادمي بمعرف idempotency؛ push غير متزامن قابل لإعادة المحاولة دون تكرار صندوق الإشعار.

## RLS مختصر ملزم

الملف: المالك يقرأ/يعدل الخاص؛ العامة عبر view تعرض الحقول المسموحة فقط. رياضات ومراكز المستخدم ذاتية؛ قواميس للقراءة والتعديل الإداري. الصداقة للطرفين، انتقالاتها عبر RPC؛ كل مستخدم ينشئ حظره الاتجاهي ويمنع الحظر التفاعل بحسب قواعد المنتج. الأنشطة المنشورة عامة ببيانات عامة؛ المسودة للمنظم؛ الخاصة للمدعو/المشارك. المشارك والمنظم يريان استجابة الدعوة المسموح بها دون بيانات اتصال خاصة؛ المنظم وحده يسجل الحضور. التعليقات لأعضاء النشاط/الجمهور بحسب النشاط، والكاتب/المشرف بصلاحيات محددة. الفرق/نتائجها للمرتبطين حسب الإعداد؛ تغييرها RPC. الملاعب المنشورة للقراءة والكتابة إدارية. التقييم العام المنشور بعد التحقق فقط؛ الكاتب لا يرفع أهليته. الإشعارات للمستلم فقط والإنشاء خدمة موثوقة. البلاغ لصاحبه حالة محدودة وللمشرف المعالجة. Storage سياسات مستقلة للمسارات والحجم.

اختبر المجهول وصاحب الحساب/النشاط والمدعو والمشارك والمستخدم الغريب والمشرف، مباشرة وعبر RPC، على القراءة والكتابة والحذف وتزوير الهوية والتزامن. لا service role في العميل. كل migration على قاعدة فارغة في CI قبل اعتمادها، والاسترجاع عبر migration معاكس فقط إذا كان آمنًا؛ وإلا migration تصحيحية مع نسخ احتياطية.

> مخطط مقترح للمراجعة، غير منفذ. PostgreSQL هو مصدر الحقيقة؛ كل جدول مكشوف عبر Supabase API يجب أن يفعّل RLS بسياسات صريحة. الوظائف بصلاحيات مرتفعة تُراجع بعناية وتضبط `search_path` وتتحقق من `auth.uid()`.
