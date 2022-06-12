-- Adminer 4.7.7 PostgreSQL dump

DROP TABLE IF EXISTS "auth_group";
DROP SEQUENCE IF EXISTS auth_group_id_seq;
CREATE SEQUENCE auth_group_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_group" (
    "id" integer DEFAULT nextval('auth_group_id_seq') NOT NULL,
    "name" character varying(150) NOT NULL,
    CONSTRAINT "auth_group_name_key" UNIQUE ("name"),
    CONSTRAINT "auth_group_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "auth_group_name_a6ea08ec_like" ON "public"."auth_group" USING btree ("name");


DROP TABLE IF EXISTS "auth_group_permissions";
DROP SEQUENCE IF EXISTS auth_group_permissions_id_seq;
CREATE SEQUENCE auth_group_permissions_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_group_permissions" (
    "id" integer DEFAULT nextval('auth_group_permissions_id_seq') NOT NULL,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL,
    CONSTRAINT "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" UNIQUE ("group_id", "permission_id"),
    CONSTRAINT "auth_group_permissions_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "public"."auth_group_permissions" USING btree ("group_id");

CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "public"."auth_group_permissions" USING btree ("permission_id");


DROP TABLE IF EXISTS "auth_permission";
DROP SEQUENCE IF EXISTS auth_permission_id_seq;
CREATE SEQUENCE auth_permission_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_permission" (
    "id" integer DEFAULT nextval('auth_permission_id_seq') NOT NULL,
    "name" character varying(255) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" character varying(100) NOT NULL,
    CONSTRAINT "auth_permission_content_type_id_codename_01ab375a_uniq" UNIQUE ("content_type_id", "codename"),
    CONSTRAINT "auth_permission_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "public"."auth_permission" USING btree ("content_type_id");

INSERT INTO "auth_permission" ("id", "name", "content_type_id", "codename") VALUES
(1,	'Can add log entry',	1,	'add_logentry'),
(2,	'Can change log entry',	1,	'change_logentry'),
(3,	'Can delete log entry',	1,	'delete_logentry'),
(4,	'Can view log entry',	1,	'view_logentry'),
(5,	'Can add permission',	2,	'add_permission'),
(6,	'Can change permission',	2,	'change_permission'),
(7,	'Can delete permission',	2,	'delete_permission'),
(8,	'Can view permission',	2,	'view_permission'),
(9,	'Can add group',	3,	'add_group'),
(10,	'Can change group',	3,	'change_group'),
(11,	'Can delete group',	3,	'delete_group'),
(12,	'Can view group',	3,	'view_group'),
(13,	'Can add user',	4,	'add_user'),
(14,	'Can change user',	4,	'change_user'),
(15,	'Can delete user',	4,	'delete_user'),
(16,	'Can view user',	4,	'view_user'),
(17,	'Can add content type',	5,	'add_contenttype'),
(18,	'Can change content type',	5,	'change_contenttype'),
(19,	'Can delete content type',	5,	'delete_contenttype'),
(20,	'Can view content type',	5,	'view_contenttype'),
(21,	'Can add session',	6,	'add_session'),
(22,	'Can change session',	6,	'change_session'),
(23,	'Can delete session',	6,	'delete_session'),
(24,	'Can view session',	6,	'view_session');

DROP TABLE IF EXISTS "auth_user";
DROP SEQUENCE IF EXISTS auth_user_id_seq;
CREATE SEQUENCE auth_user_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_user" (
    "id" integer DEFAULT nextval('auth_user_id_seq') NOT NULL,
    "password" character varying(128) NOT NULL,
    "last_login" timestamptz,
    "is_superuser" boolean NOT NULL,
    "username" character varying(150) NOT NULL,
    "first_name" character varying(150) NOT NULL,
    "last_name" character varying(150) NOT NULL,
    "email" character varying(254) NOT NULL,
    "is_staff" boolean NOT NULL,
    "is_active" boolean NOT NULL,
    "date_joined" timestamptz NOT NULL,
    CONSTRAINT "auth_user_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "auth_user_username_key" UNIQUE ("username")
) WITH (oids = false);

CREATE INDEX "auth_user_username_6821ab7c_like" ON "public"."auth_user" USING btree ("username");


DROP TABLE IF EXISTS "auth_user_groups";
DROP SEQUENCE IF EXISTS auth_user_groups_id_seq;
CREATE SEQUENCE auth_user_groups_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_user_groups" (
    "id" integer DEFAULT nextval('auth_user_groups_id_seq') NOT NULL,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL,
    CONSTRAINT "auth_user_groups_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "auth_user_groups_user_id_group_id_94350c0c_uniq" UNIQUE ("user_id", "group_id"),
    CONSTRAINT "auth_user_groups_group_id_97559544_fk_auth_group_id" FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id" FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "auth_user_groups_group_id_97559544" ON "public"."auth_user_groups" USING btree ("group_id");

CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "public"."auth_user_groups" USING btree ("user_id");


DROP TABLE IF EXISTS "auth_user_user_permissions";
DROP SEQUENCE IF EXISTS auth_user_user_permissions_id_seq;
CREATE SEQUENCE auth_user_user_permissions_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."auth_user_user_permissions" (
    "id" integer DEFAULT nextval('auth_user_user_permissions_id_seq') NOT NULL,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL,
    CONSTRAINT "auth_user_user_permissions_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" UNIQUE ("user_id", "permission_id"),
    CONSTRAINT "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm" FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id" FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "public"."auth_user_user_permissions" USING btree ("permission_id");

CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "public"."auth_user_user_permissions" USING btree ("user_id");


DROP TABLE IF EXISTS "basket_detail";
DROP SEQUENCE IF EXISTS basket_detail_id_seq;
CREATE SEQUENCE basket_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."basket_detail" (
    "id" integer DEFAULT nextval('basket_detail_id_seq') NOT NULL,
    "quantity" integer,
    "meals_time" character varying(150),
    "date" character varying(150),
    "price" integer,
    "created_at" timestamptz NOT NULL,
    "basket_id" integer,
    "meals_id" integer,
    "merchant_id" integer,
    CONSTRAINT "basket_detail_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "basket_detail_basket_id_9c6ad100_fk_baskets_id" FOREIGN KEY (basket_id) REFERENCES baskets(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "basket_detail_meals_id_21178a67_fk_meals_id" FOREIGN KEY (meals_id) REFERENCES meals(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "basket_detail_merchant_id_01f347fb_fk_merchants_id" FOREIGN KEY (merchant_id) REFERENCES merchants(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "basket_detail_basket_id_9c6ad100" ON "public"."basket_detail" USING btree ("basket_id");

CREATE INDEX "basket_detail_meals_id_21178a67" ON "public"."basket_detail" USING btree ("meals_id");

CREATE INDEX "basket_detail_merchant_id_01f347fb" ON "public"."basket_detail" USING btree ("merchant_id");

INSERT INTO "basket_detail" ("id", "quantity", "meals_time", "date", "price", "created_at", "basket_id", "meals_id", "merchant_id") VALUES
(1,	NULL,	'dinner',	NULL,	10000,	'2022-06-11 07:16:50.636237+07',	3,	1,	NULL),
(2,	2,	'dinner',	NULL,	10000,	'2022-06-11 07:17:17.444705+07',	4,	1,	NULL),
(3,	2,	'dinner',	'2022-06-06',	10000,	'2022-06-11 07:17:40.080447+07',	5,	1,	NULL),
(4,	2,	'dinner',	'2022-06-06',	10000,	'2022-06-11 07:18:22.291247+07',	6,	1,	NULL),
(5,	2,	'dinner',	'2022-06-06',	10000,	'2022-06-11 07:20:27.611714+07',	7,	1,	NULL),
(6,	2,	'dinner',	'2022-06-06',	10000,	'2022-06-11 07:20:50.419224+07',	8,	1,	NULL),
(101,	1,	'lunch',	'2022-06-13',	30000,	'2022-06-12 07:51:16.994701+07',	61,	13,	NULL);

DROP TABLE IF EXISTS "baskets";
DROP SEQUENCE IF EXISTS baskets_id_seq;
CREATE SEQUENCE baskets_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."baskets" (
    "id" integer DEFAULT nextval('baskets_id_seq') NOT NULL,
    "type" character varying(150),
    "duration" character varying(150),
    "quantity" integer,
    "meals_time" character varying(150),
    "selected_date" character varying(150),
    "subtotal" integer,
    "order_fee" integer,
    "total" integer,
    "user_id" integer,
    "created_at" timestamptz NOT NULL,
    "merchant_id" integer,
    "start_date" character varying(150),
    CONSTRAINT "baskets_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "baskets_merchant_id_10eb4214_fk_merchants_id" FOREIGN KEY (merchant_id) REFERENCES merchants(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "baskets_merchant_id_10eb4214" ON "public"."baskets" USING btree ("merchant_id");

INSERT INTO "baskets" ("id", "type", "duration", "quantity", "meals_time", "selected_date", "subtotal", "order_fee", "total", "user_id", "created_at", "merchant_id", "start_date") VALUES
(1,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:15:57.707869+07',	NULL,	NULL),
(2,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:16:21.639486+07',	NULL,	NULL),
(3,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:16:50.351749+07',	NULL,	NULL),
(4,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:17:17.273246+07',	NULL,	NULL),
(5,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:17:39.868982+07',	NULL,	NULL),
(6,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:18:22.069848+07',	NULL,	NULL),
(7,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:20:27.422596+07',	NULL,	NULL),
(8,	'daily',	NULL,	NULL,	NULL,	'2022-06-06',	NULL,	NULL,	NULL,	NULL,	'2022-06-11 07:20:50.234144+07',	NULL,	NULL),
(61,	'daily',	NULL,	NULL,	NULL,	'2022-06-13',	NULL,	NULL,	NULL,	123,	'2022-06-12 07:51:16.98916+07',	NULL,	'2022-06-13');

DROP TABLE IF EXISTS "django_admin_log";
DROP SEQUENCE IF EXISTS django_admin_log_id_seq;
CREATE SEQUENCE django_admin_log_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."django_admin_log" (
    "id" integer DEFAULT nextval('django_admin_log_id_seq') NOT NULL,
    "action_time" timestamptz NOT NULL,
    "object_id" text,
    "object_repr" character varying(200) NOT NULL,
    "action_flag" smallint NOT NULL,
    "change_message" text NOT NULL,
    "content_type_id" integer,
    "user_id" integer NOT NULL,
    CONSTRAINT "django_admin_log_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "django_admin_log_user_id_c564eba6_fk_auth_user_id" FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "public"."django_admin_log" USING btree ("content_type_id");

CREATE INDEX "django_admin_log_user_id_c564eba6" ON "public"."django_admin_log" USING btree ("user_id");


DROP TABLE IF EXISTS "django_content_type";
DROP SEQUENCE IF EXISTS django_content_type_id_seq;
CREATE SEQUENCE django_content_type_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."django_content_type" (
    "id" integer DEFAULT nextval('django_content_type_id_seq') NOT NULL,
    "app_label" character varying(100) NOT NULL,
    "model" character varying(100) NOT NULL,
    CONSTRAINT "django_content_type_app_label_model_76bd3d3b_uniq" UNIQUE ("app_label", "model"),
    CONSTRAINT "django_content_type_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "django_content_type" ("id", "app_label", "model") VALUES
(1,	'admin',	'logentry'),
(2,	'auth',	'permission'),
(3,	'auth',	'group'),
(4,	'auth',	'user'),
(5,	'contenttypes',	'contenttype'),
(6,	'sessions',	'session');

DROP TABLE IF EXISTS "django_migrations";
DROP SEQUENCE IF EXISTS django_migrations_id_seq;
CREATE SEQUENCE django_migrations_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."django_migrations" (
    "id" integer DEFAULT nextval('django_migrations_id_seq') NOT NULL,
    "app" character varying(255) NOT NULL,
    "name" character varying(255) NOT NULL,
    "applied" timestamptz NOT NULL,
    CONSTRAINT "django_migrations_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "django_migrations" ("id", "app", "name", "applied") VALUES
(1,	'contenttypes',	'0001_initial',	'2022-06-11 05:30:14.794322+07'),
(2,	'auth',	'0001_initial',	'2022-06-11 05:30:15.843383+07'),
(3,	'admin',	'0001_initial',	'2022-06-11 05:30:19.626318+07'),
(4,	'admin',	'0002_logentry_remove_auto_add',	'2022-06-11 05:30:20.359286+07'),
(5,	'admin',	'0003_logentry_add_action_flag_choices',	'2022-06-11 05:30:21.258272+07'),
(6,	'contenttypes',	'0002_remove_content_type_name',	'2022-06-11 05:30:21.776434+07'),
(7,	'auth',	'0002_alter_permission_name_max_length',	'2022-06-11 05:30:22.197277+07'),
(8,	'auth',	'0003_alter_user_email_max_length',	'2022-06-11 05:30:22.690578+07'),
(9,	'auth',	'0004_alter_user_username_opts',	'2022-06-11 05:30:23.036255+07'),
(10,	'auth',	'0005_alter_user_last_login_null',	'2022-06-11 05:30:24.642147+07'),
(11,	'auth',	'0006_require_contenttypes_0002',	'2022-06-11 05:30:24.99413+07'),
(12,	'auth',	'0007_alter_validators_add_error_messages',	'2022-06-11 05:30:25.340253+07'),
(13,	'auth',	'0008_alter_user_username_max_length',	'2022-06-11 05:30:25.790213+07'),
(14,	'auth',	'0009_alter_user_last_name_max_length',	'2022-06-11 05:30:26.223878+07'),
(15,	'auth',	'0010_alter_group_name_max_length',	'2022-06-11 05:30:27.184266+07'),
(16,	'auth',	'0011_update_proxy_permissions',	'2022-06-11 05:30:27.529048+07'),
(17,	'auth',	'0012_alter_user_first_name_max_length',	'2022-06-11 05:30:27.999284+07'),
(18,	'rest_admin',	'0001_initial',	'2022-06-11 05:30:30.263373+07'),
(19,	'sessions',	'0001_initial',	'2022-06-11 05:30:33.195308+07'),
(20,	'rest_admin',	'0002_auto_20220611_0552',	'2022-06-11 05:52:25.827089+07'),
(21,	'rest_admin',	'0003_basket_start_date',	'2022-06-11 07:49:01.877013+07'),
(22,	'rest_admin',	'0004_orders_start_date',	'2022-06-11 13:40:07.230464+07');

DROP TABLE IF EXISTS "django_session";
CREATE TABLE "public"."django_session" (
    "session_key" character varying(40) NOT NULL,
    "session_data" text NOT NULL,
    "expire_date" timestamptz NOT NULL,
    CONSTRAINT "django_session_pkey" PRIMARY KEY ("session_key")
) WITH (oids = false);

CREATE INDEX "django_session_expire_date_a5c62663" ON "public"."django_session" USING btree ("expire_date");

CREATE INDEX "django_session_session_key_c0390e0f_like" ON "public"."django_session" USING btree ("session_key");


DROP TABLE IF EXISTS "meals";
DROP SEQUENCE IF EXISTS meals_id_seq;
CREATE SEQUENCE meals_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."meals" (
    "id" integer DEFAULT nextval('meals_id_seq') NOT NULL,
    "name" character varying(150) NOT NULL,
    "category" character varying(150) NOT NULL,
    "meals_time" character varying(250) NOT NULL,
    "thumbnail" text NOT NULL,
    "price" integer,
    "created_at" timestamptz NOT NULL,
    "merchant_id" integer NOT NULL,
    "date" character varying(250),
    "description" text,
    CONSTRAINT "meals_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "meals_merchant_id_73113753_fk_merchants_id" FOREIGN KEY (merchant_id) REFERENCES merchants(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "meals_merchant_id_73113753" ON "public"."meals" USING btree ("merchant_id");

INSERT INTO "meals" ("id", "name", "category", "meals_time", "thumbnail", "price", "created_at", "merchant_id", "date", "description") VALUES
(12,	'Ayam Goreng Kuning',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/menu-ayam-goreng-kuning.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-14',	'Fried chicken with vegetables and sambal'),
(19,	'Cah Ayam Kampung',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/Cah_Ayam_Kampung_Serai_PDK.jpeg',	45000,	'2022-06-11 06:19:40.159393+07',	9,	'2022-06-14',	'Nikmati menu makan sehat yang lezat dan mengenyangkan. Kreasi hidangan ayam yang mengandung rendah lemak, kalori serta mengandung protein. Disajikan lengkap dengan Blanched Quinoa dan Sauteed Broccoli Cauliflower'),
(13,	'Chicken Curry',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/menu-opor-ayam.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-13',	'Delicious curry for your lunch'),
(17,	'Ayam Bakar Kalasan Fit',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/Ayam_Bakar_Kalasan_WL.jpg',	45000,	'2022-06-11 06:19:40.159393+07',	9,	'2022-06-12',	'Pecinta kuliner Indonesia jangan sampai melewatkan menu Ayam Bakar Kalasan ala Gorry Gourmet. Tidak hanya lezat tapi juga menyehatkan karena mengandung rendah lemak dan kalori serta mengandung protein. Disajikan lengkap dengan Nasi Coklat, Tempe Kering, dan Tumis Buncis Wortel'),
(18,	'Meatball and Sauce',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/Bola_Bola_Daging_Cincang_PDK.jpeg',	45000,	'2022-06-11 06:19:40.159393+07',	9,	'2022-06-13',	'Kreasi menu Bola-Bola Daging Cincang yang menggunakan daging pilihan yang minim akan lemak dan tinggi akan protein serta zat besi. Disajikan lengkap dengan Bubur Nasi Merah, Tumis Jamur Merang Cincang, dan Cah Sawi Putih Wortel Cincang'),
(20,	'Sate Lilit Ikan',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/Sate_Lilit_Ikan_WL.jpg',	45000,	'2022-06-11 06:19:40.159393+07',	9,	'2022-06-14',	'Ikan yang kaya akan asam lemak omega 3, disulap menjadi hidangan sate lilit khas pulau Dewata dan disajikan dengan saus yang gurih dan aromatik.'),
(21,	'Tuna Suwir',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/Tuna_Suwir_Kemangi_HB22.jpg',	45000,	'2022-06-11 06:19:40.159393+07',	9,	'2022-06-15',	'Hidangan khas Nusantara Ikan Tuna Suwir dengan aroma daun kemangi yang nikmat, disajikan dengan Bakmie Goreng, Telur Dadar Iris, dan Tumis Buncis Wortel'),
(14,	'Tuna Cabe Ijo',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/tuna%20cabe%20ijo.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-16',	'Tuna cabe ijo to the rescue'),
(11,	'Nasi Ayam Bakar',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/ayambakar-fix.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-12',	'Grilled chicken is the best dish'),
(22,	'Chicken Katsu',	'Western',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/Chicken-Katsu.jpg',	55000,	'2022-06-11 06:19:40.159393+07',	6,	'2022-06-13',	'Chicken Katsu with salad, potatoes and mayo sauce'),
(23,	'Spaghetti Bolognese',	'Western',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/Spaghetti-Bolognese.jpg',	55000,	'2022-06-11 06:19:40.159393+07',	6,	'2022-06-13',	'Spaghetti Bolognese dengan sosis bakar BBQ and vegetables'),
(15,	'Chicken Wing BBQ',	'Western',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/chicken-wing-barbeque.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	6,	'2022-06-14',	'Chcicken Wing BBQ with vegetables and potatoes'),
(16,	'Steak Ayam ',	'Western',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/Steik-Ayam-bbq.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	6,	'2022-06-15',	'Steak Ayam with saluted sauce and potatoes'),
(24,	'Mystery Bento',	'Mystery',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/mystery.png',	30000,	'2022-06-12 04:17:25.237561+07',	3,	NULL,	'Tired of ordering the food by yourself ?'),
(1,	'Ayam Goreng Sambel Ijo',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/Ayam-Goreng-Sambal-Ijo.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-15',	'Spicy foods with tasty fried chicken'),
(2,	'Tongkol Pindang Lodeh',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nusantara/Tongkol-Pindang-Lodeh.jpg',	30000,	'2022-06-11 06:19:40.159393+07',	1,	'2022-06-17',	'Ikan tongkol dimasak pindah dicampur dengan katsu');

DROP TABLE IF EXISTS "merchants";
DROP SEQUENCE IF EXISTS merchants_id_seq;
CREATE SEQUENCE merchants_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."merchants" (
    "id" integer DEFAULT nextval('merchants_id_seq') NOT NULL,
    "name" character varying(150) NOT NULL,
    "category" character varying(150) NOT NULL,
    "meals_time" character varying(250),
    "thumbnail" text NOT NULL,
    "price" integer,
    "created_at" timestamptz NOT NULL,
    "description" text,
    "rating" character varying(250),
    "reviews" character varying(250),
    CONSTRAINT "merchants_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "merchants" ("id", "name", "category", "meals_time", "thumbnail", "price", "created_at", "description", "rating", "reviews") VALUES
(4,	'Mommy Pasta',	'Western',	'dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/spaghetti.jpg',	40000,	'2022-06-11 05:53:10.564483+07',	'The best pasta in the city that you should never miss',	'4.7',	'34'),
(5,	'Uncle Salad',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/saladcaesar.jpeg',	45000,	'2022-06-11 05:53:10.564483+07',	'Clean eating in affordable price for your healthy lifestyle',	'4.4',	'281'),
(1,	'Keraton Catering',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/nasi-goreng-jawa.jpg',	30000,	'2022-06-11 05:53:10.564483+07',	'Indonesian food will never disappoint your hunger',	'4.3',	'140'),
(6,	'The West and Breeze',	'Western',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/burger.jpg',	55000,	'2022-06-11 05:53:10.564483+07',	'The meats and taste you will never seen in others place',	'4.2',	'102'),
(7,	'Sushi Guys',	'Oriental',	'lunch',	'https://storage.googleapis.com/cdn-grab-hackathon/images/sushi%20big.jpg',	45000,	'2022-06-11 05:53:10.564483+07',	'Japanese taste on your lunchbox',	'4.9',	'341'),
(8,	'Oma Chinese Food',	'Oriental',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/capcai.jpg',	35000,	'2022-06-11 05:53:10.564483+07',	'The legend chinese food stall now available in your lunchbox without hassle',	'4.3',	'58'),
(9,	'Vegan Box',	'Healthy',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/resep-pecel-sayur.jpg',	45000,	'2022-06-11 05:53:10.564483+07',	'Vegan lifestyle for your health. Only plant based foods that served in your lunchbo',	'4.1',	'66'),
(2,	'Meatza',	'Western',	'dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/steak%20big.jpg',	40000,	'2022-06-11 05:53:10.564483+07',	'The taste of selected meats and western food that will brings you joy',	'4.2',	'89'),
(10,	'Sanji''s Kitchen',	'Nusantara',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/rendang.jpg',	35000,	'2022-06-11 05:53:10.564483+07',	'Ready to fill your hungry stomach during lunch and dinner with original Indonesian taste ',	'4.2',	'140'),
(3,	'Mystery Bento',	'Mystery',	'lunch,dinner',	'https://storage.googleapis.com/cdn-grab-hackathon/images/mystery.png',	30000,	'2022-06-11 13:10:09.731741+07',	'Bored with the menu and doesnt have time to choose your meals? Let us handle that for you',	'1.1',	'145');

DROP TABLE IF EXISTS "order_detail";
DROP SEQUENCE IF EXISTS order_detail_id_seq;
CREATE SEQUENCE order_detail_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."order_detail" (
    "id" integer DEFAULT nextval('order_detail_id_seq') NOT NULL,
    "quantity" integer,
    "meals_time" character varying(150),
    "date" character varying(150),
    "price" integer,
    "created_at" timestamptz NOT NULL,
    "meals_id" integer,
    "merchant_id" integer,
    "order_id" integer,
    CONSTRAINT "order_detail_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "order_detail_meals_id_7f5a0648_fk_meals_id" FOREIGN KEY (meals_id) REFERENCES meals(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "order_detail_merchant_id_748f6ea7_fk_merchants_id" FOREIGN KEY (merchant_id) REFERENCES merchants(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE,
    CONSTRAINT "order_detail_order_id_b97dfbdf_fk_orders_id" FOREIGN KEY (order_id) REFERENCES orders(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "order_detail_meals_id_7f5a0648" ON "public"."order_detail" USING btree ("meals_id");

CREATE INDEX "order_detail_merchant_id_748f6ea7" ON "public"."order_detail" USING btree ("merchant_id");

CREATE INDEX "order_detail_order_id_b97dfbdf" ON "public"."order_detail" USING btree ("order_id");

INSERT INTO "order_detail" ("id", "quantity", "meals_time", "date", "price", "created_at", "meals_id", "merchant_id", "order_id") VALUES
(41,	2,	'lunch',	'2022-06-14',	30000,	'2022-06-12 07:10:06.746741+07',	12,	1,	24),
(42,	2,	'lunch',	'2022-06-14',	30000,	'2022-06-12 07:36:00.805303+07',	12,	1,	25),
(43,	2,	'lunch',	'2022-06-14',	30000,	'2022-06-12 07:36:00.8092+07',	13,	1,	25),
(36,	2,	'lunch',	'2022-06-13',	30000,	'2022-05-12 07:08:14.524512+07',	13,	1,	23),
(37,	2,	'lunch',	'2022-06-14',	30000,	'2022-05-12 07:08:14.524512+07',	12,	1,	23),
(38,	2,	'lunch',	'2022-06-15',	30000,	'2022-05-12 07:08:14.524512+07',	1,	1,	23),
(39,	2,	'lunch',	'2022-06-16',	30000,	'2022-05-12 07:08:14.524512+07',	14,	1,	23),
(40,	2,	'lunch',	'2022-06-17',	30000,	'2022-05-12 07:08:14.524512+07',	2,	1,	23),
(44,	2,	'dinner',	'2022-06-14',	30000,	'2022-06-12 09:24:06.287754+07',	24,	3,	26),
(45,	2,	'dinner',	'2022-06-15',	30000,	'2022-06-12 09:24:06.291344+07',	24,	3,	26),
(46,	2,	'dinner',	'2022-06-16',	30000,	'2022-06-12 09:24:06.293547+07',	24,	3,	26),
(47,	2,	'dinner',	'2022-06-17',	30000,	'2022-06-12 09:24:06.296857+07',	24,	3,	26),
(48,	2,	'dinner',	'2022-06-18',	30000,	'2022-06-12 09:24:06.298806+07',	24,	3,	26);

DROP TABLE IF EXISTS "orders";
DROP SEQUENCE IF EXISTS orders_id_seq;
CREATE SEQUENCE orders_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."orders" (
    "id" integer DEFAULT nextval('orders_id_seq') NOT NULL,
    "type" character varying(150),
    "duration" character varying(150),
    "quantity" integer,
    "meals_time" character varying(150),
    "selected_date" character varying(150),
    "subtotal" integer,
    "order_fee" integer,
    "total" integer,
    "user_id" integer,
    "created_at" timestamptz NOT NULL,
    "merchant_id" integer,
    "start_date" character varying(150),
    CONSTRAINT "orders_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "orders_merchant_id_a8f14617_fk_merchants_id" FOREIGN KEY (merchant_id) REFERENCES merchants(id) DEFERRABLE INITIALLY DEFERRED DEFERRABLE
) WITH (oids = false);

CREATE INDEX "orders_merchant_id_a8f14617" ON "public"."orders" USING btree ("merchant_id");

INSERT INTO "orders" ("id", "type", "duration", "quantity", "meals_time", "selected_date", "subtotal", "order_fee", "total", "user_id", "created_at", "merchant_id", "start_date") VALUES
(24,	'package',	'1',	2,	'lunch',	NULL,	60000,	6000,	66000,	123,	'2022-06-12 07:10:06.740751+07',	1,	'2022-06-14'),
(25,	'daily',	NULL,	NULL,	NULL,	'2022-06-14',	120000,	6000,	126000,	123,	'2022-06-12 07:36:00.801509+07',	NULL,	'2022-06-14'),
(23,	'package',	'5',	2,	'lunch',	NULL,	300000,	6000,	306000,	123,	'2022-05-12 07:08:14.524512+07',	1,	'2022-06-13'),
(26,	'mysterious',	'5',	2,	'dinner',	NULL,	60000,	6000,	66000,	123,	'2022-06-12 09:24:06.277233+07',	NULL,	'2022-06-14');

-- 2022-06-12 21:49:37.459749+07
