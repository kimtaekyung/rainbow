/**
 * 상수 정의
 */
//정규식
var ID_REGULAR_EXPRESSTION 				= /^[a-zA-Z0-9_]{3,20}$/;       //a~z 또는 A~Z 또는 0~9 _ 입력 가능 하고 4~20글자
var PW_REGULAR_EXPRESSTION				= /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var NAME_REGULAR_EXPRESSTION			= /^[가-힣]{2,4}$/;
var NICKNAME_REGULAR_EXPRESSTION 		= /^[0-9a-zA-Z가-힣]{1,20}$/;
var BIRTH_REGULAR_EXPRESSTION			= /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/;
var TEL_REGULAR_EXPRESSTION				= /^\d{2,3}-\d{3,4}-\d{4}$/;
var HP_REGULAR_EXPRESSTION				= /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/;
var EMAIL_REGULAR_EXPRESSTION			= /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
var BIZNAME_REGULAR_EXPRESSTION 		= /^[0-9a-zA-Z가-힣]{1,20}$/;
var BIZCEONAME_REGULAR_EXPRESSTION 		= /^[가-힣]{2,4}$/;
var BIZNO_REGULAR_EXPRESSTION			= /([0-9]{3})-([0-9]{2})-([0-9]{5})/;
var ZIPCODE_REGULAR_EXPRESSTION			= /^[0-9]{5,6}$/;
var ADDRESS_REGULAR_EXPRESSTION			= /^[0-9a-zA-Z가-힣\s]{1,50}$/;
var ADDRESS_DETAIL_REGULAR_EXPRESSTION	= /^[0-9a-zA-Z가-힣\s]{1,50}$/;
var BIZTELNO_REGULAR_EXPRESSTION		= /^\d{2,3}-\d{3,4}-\d{4}$/;
var SELLCODE_REGULAR_EXPRESSTION		= /^[0-9a-zA-Z]{1,70}$/;
var SPACE_REGULAR_EXPRESSTION			= /\s/g;
var ONE_NUMBER_REGULAR_EXPRESSTION		= /^[0-9]{1}/;
var BANK_OWNER_EXPRESSTION				= /^[가-힣]{2,4}$/;
var BANK_NAME_EXPRESSTION				= /^[a-zA-Z가-힣]{2,10}$/;
var BANK_NO_EXPRESSTION					= /^[0-9]{5,30}/;
var BIZ_TYPE_EXPRESSTION				= /^[가-힣]{1,10}$/;
var BIZ_CONDITION_EXPRESSTION			= /^[가-힣]{1,10}$/;
var BIZ_CATEGORY_EXPRESSTION			= /^[가-힣]{1,10}$/;
var LEAVE_REASON_EXPRESSTION			= /^[0-9a-zA-Z가-힣\s]{1,100}$/;
var IP_REASON_EXPRESSTION				= /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
var SUPPORT_TYPE_REGULAR_EXPRESSTION	= /^[0-9]{1,2}/;
var EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION = /^[0-9]{5,10}/;

var PRICE_EXPRESSION				= /^\d{1,8}$/;
var DATE_EXPRESSION					= /^(19|20)\d{2}-?(0[1-9]|1[012])-?(0[1-9]|[12][0-9]|3[0-1])$/;
var ITEM_CATEGORY1_EXPRESSION		= /^C[0-9]{2}/;
var ITEM_CATEGORY2_EXPRESSION		= /^C[0-9]{4}/;

var NUMBER_EXPRESSION				= /^[0-9]*$/;
var IMAGE_EXPRESSION				= /(\.gif|\.jpg|\.jpeg|\.png)$/;

//ajax result
var AJAX_RESULT_SUCCESS				= "SUCCESS";
var AJAX_RESULT_FAIL				= "FAIL";

//최근본 아이템 삭제 기간
var LATELY_VIEW_ITEM_EXPIRATION_DATE = 1;
//최근본 아이템 최대 저장 개수
var LATELY_VIEW_ITEM_MAX_SAVE_COUNT = 50;
//최근본 아이템 페이징 사이즈
var LATELY_VIEW_ITEM_PAGEING_SIZE = 5;

//jbox 관련 변수
var JBOX_MODAL;
var JBOX_IMAGE;
