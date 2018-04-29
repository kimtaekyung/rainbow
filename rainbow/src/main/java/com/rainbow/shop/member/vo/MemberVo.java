package com.rainbow.shop.member.vo;

import java.io.Serializable;

public class MemberVo implements Serializable {

	private static final long serialVersionUID = 1L;
	
//	mb_seq	int(10) unsigned
//	mb_id	varchar(20)
//	mb_password	varchar(255)
//	mb_name	varchar(20)
//	mb_nickname	varchar(20)
//	mb_birthday	char(8)
//	mb_birthday_type	tinyint(1)
//	mb_tel	varchar(15)
//	mb_hp	varchar(15)
//	mb_email	varchar(100)
	
	
	
	
	
//	mb_zip_code	varchar(10)
//	mb_address	varchar(255)
//	mb_address_detail	varchar(255)
//	mb_address_type	tinyint(1)
//	mb_biz_name	varchar(255)
//	mb_biz_ceo_name	varchar(255)
//	mb_biz_no	varchar(15)
//	mb_biz_tel	varchar(20)
//	mb_biz_address	varchar(255)
//	mb_biz_type_1	tinyint(1)
//	mb_biz_type_2	tinyint(1)
//	mb_biz_type_3	tinyint(1)
//	mb_biz_type_4	tinyint(1)
//	mb_biz_type_5	tinyint(1)
//	mb_biz_code	varchar(255)
//	mb_info_recv_mail	tinyint(1)
//	mb_info_recv_post	tinyint(1)
//	mb_info_recv_sms	tinyint(1)
//	mb_info_recv_hp	tinyint(1)
//	mb_info_open	tinyint(1)
//	mb_recomm_id	int(1) unsigned
//	mb_state	tinyint(1)
//	mb_type	tinyint(1)
//	mb_is_login	tinyint(1)
//	mb_login_ip	varchar(20)
//	grade_seq	int(10) unsigned
//	mb_cash	int(10) unsigned
//	mb_point	int(10) unsigned
//	mb_reg_dttm	datetime
//	mb_leave_dttm	datetime
	
	private int 		mbSeq;
	private String 		mbId;
	private String 		mbPassword;
	private String 		mbName;
	private String 		mbNickname;
	private String 		mbBirthday;
	private int 		mbBirthdayType;
	private String 		mbTel;
	private String 		mbHp;
	private String 		mbEmail;
	private String 		mbZipCode;
	private String 		mbAddress;
	private String 		mbAddressDetail;
	private int 		mbAddressType;
	private String 		mbBizName;
	private String 		mbBizCeoName;
	private String 		mbBizNo;
	private String 		mbBizTel;
	private String 		mbBizAddress;
	private int 		mbBizType1;
	private int 		mbBizType2;
	private int 		mbBizType3;
	private int 		mbBizType4;
	private int 		mbBizType5;
	private String 		mbBizCode;
	private int 		mbInfoRecvMail; 	
	private int 		mbInfoRecvPost; 	
	private int 		mbInfoRecvSms; 	
	private int 		mbInfoRecvHp;
	private int 		mbInfoOpen;
	private int 		mbRecommId;
	private int 		mbState;
	private int 		mbType;
	private int 		mbIsLogin;
	private String 		mbLoginIp;
	private int			gradeSeq;
	private int 		mbCash;
	private int 		mbPoint;
	private String 		mbBizAddressDetail;
	
	public int getMbSeq() {
		return mbSeq;
	}
	public MemberVo setMbSeq(int mbSeq) {
		this.mbSeq = mbSeq;
		return this;
	}
	public String getMbId() {
		return mbId;
	}
	public MemberVo setMbId(String mbId) {
		this.mbId = mbId;
		return this;
	}
	public String getMbPassword() {
		return mbPassword;
	}
	public MemberVo setMbPassword(String mbPassword) {
		this.mbPassword = mbPassword;
		return this;
	}
	public String getMbName() {
		return mbName;
	}
	public MemberVo setMbName(String mbName) {
		this.mbName = mbName;
		return this;
	}
	public String getMbNickname() {
		return mbNickname;
	}
	public MemberVo setMbNickname(String mbNickname) {
		this.mbNickname = mbNickname;
		return this;
	}
	public String getMbBirthday() {
		return mbBirthday;
	}
	public MemberVo setMbBirthday(String mbBirthday) {
		this.mbBirthday = mbBirthday;
		return this;
	}
	public int getMbBirthdayType() {
		return mbBirthdayType;
	}
	public MemberVo setMbBirthdayType(int mbBirthdayType) {
		this.mbBirthdayType = mbBirthdayType;
		return this;
	}
	public String getMbTel() {
		return mbTel;
	}
	public MemberVo setMbTel(String mbTel) {
		this.mbTel = mbTel;
		return this;
	}
	public String getMbHp() {
		return mbHp;
	}
	public MemberVo setMbHp(String mbHp) {
		this.mbHp = mbHp;
		return this;
	}
	public String getMbEmail() {
		return mbEmail;
	}
	public MemberVo setMbEmail(String mbEmail) {
		this.mbEmail = mbEmail;
		return this;
	}
	public String getMbZipCode() {
		return mbZipCode;
	}
	public MemberVo setMbZipCode(String mbZipCode) {
		this.mbZipCode = mbZipCode;
		return this;
	}
	public String getMbAddress() {
		return mbAddress;
	}
	public MemberVo setMbAddress(String mbAddress) {
		this.mbAddress = mbAddress;
		return this;
	}
	public String getMbAddressDetail() {
		return mbAddressDetail;
	}
	public MemberVo setMbAddressDetail(String mbAddressDetail) {
		this.mbAddressDetail = mbAddressDetail;
		return this;
	}
	public int getMbAddressType() {
		return mbAddressType;
	}
	public MemberVo setMbAddressType(int mbAddressType) {
		this.mbAddressType = mbAddressType;
		return this;
	}
	public String getMbBizName() {
		return mbBizName;
	}
	public MemberVo setMbBizName(String mbBizName) {
		this.mbBizName = mbBizName;
		return this;
	}
	public String getMbBizCeoName() {
		return mbBizCeoName;
	}
	public MemberVo setMbBizCeoName(String mbBizCeoName) {
		this.mbBizCeoName = mbBizCeoName;
		return this;
	}
	public String getMbBizNo() {
		return mbBizNo;
	}
	public MemberVo setMbBizNo(String mbBizNo) {
		this.mbBizNo = mbBizNo;
		return this;
	}
	public String getMbBizTel() {
		return mbBizTel;
	}
	public MemberVo setMbBizTel(String mbBizTel) {
		this.mbBizTel = mbBizTel;
		return this;
	}
	public String getMbBizAddress() {
		return mbBizAddress;
	}
	public MemberVo setMbBizAddress(String mbBizAddress) {
		this.mbBizAddress = mbBizAddress;
		return this;
	}
	public int getMbBizType1() {
		return mbBizType1;
	}
	public MemberVo setMbBizType1(int mbBizType1) {
		this.mbBizType1 = mbBizType1;
		return this;
	}
	public int getMbBizType2() {
		return mbBizType2;
	}
	public MemberVo setMbBizType2(int mbBizType2) {
		this.mbBizType2 = mbBizType2;
		return this;
	}
	public int getMbBizType3() {
		return mbBizType3;
	}
	public MemberVo setMbBizType3(int mbBizType3) {
		this.mbBizType3 = mbBizType3;
		return this;
	}
	public int getMbBizType4() {
		return mbBizType4;
	}
	public MemberVo setMbBizType4(int mbBizType4) {
		this.mbBizType4 = mbBizType4;
		return this;
	}
	public int getMbBizType5() {
		return mbBizType5;
	}
	public MemberVo setMbBizType5(int mbBizType5) {
		this.mbBizType5 = mbBizType5;
		return this;
	}
	public String getMbBizCode() {
		return mbBizCode;
	}
	public MemberVo setMbBizCode(String mbBizCode) {
		this.mbBizCode = mbBizCode;
		return this;
	}
	public int getMbInfoRecvMail() {
		return mbInfoRecvMail;
	}
	public MemberVo setMbInfoRecvMail(int mbInfoRecvMail) {
		this.mbInfoRecvMail = mbInfoRecvMail;
		return this;
	}
	public int getMbInfoRecvPost() {
		return mbInfoRecvPost;
	}
	public MemberVo setMbInfoRecvPost(int mbInfoRecvPost) {
		this.mbInfoRecvPost = mbInfoRecvPost;
		return this;
	}
	public int getMbInfoRecvSms() {
		return mbInfoRecvSms;
	}
	public MemberVo setMbInfoRecvSms(int mbInfoRecvSms) {
		this.mbInfoRecvSms = mbInfoRecvSms;
		return this;
	}
	public int getMbInfoRecvHp() {
		return mbInfoRecvHp;
	}
	public MemberVo setMbInfoRecvHp(int mbInfoRecvHp) {
		this.mbInfoRecvHp = mbInfoRecvHp;
		return this;
	}
	public int getMbInfoOpen() {
		return mbInfoOpen;
	}
	public MemberVo setMbInfoOpen(int mbInfoOpen) {
		this.mbInfoOpen = mbInfoOpen;
		return this;
	}
	public int getMbRecommId() {
		return mbRecommId;
	}
	public MemberVo setMbRecommId(int mbRecommId) {
		this.mbRecommId = mbRecommId;
		return this;
	}
	public int getMbState() {
		return mbState;
	}
	public MemberVo setMbState(int mbState) {
		this.mbState = mbState;
		return this;
	}
	public int getMbType() {
		return mbType;
	}
	public MemberVo setMbType(int mbType) {
		this.mbType = mbType;
		return this;
	}
	public int getMbIsLogin() {
		return mbIsLogin;
	}
	public MemberVo setMbIsLogin(int mbIsLogin) {
		this.mbIsLogin = mbIsLogin;
		return this;
	}
	public String getMbLoginIp() {
		return mbLoginIp;
	}
	public MemberVo setMbLoginIp(String mbLoginIp) {
		this.mbLoginIp = mbLoginIp;
		return this;
	}
	public int getGradeSeq() {
		return gradeSeq;
	}
	public MemberVo setGradeSeq(int gradeSeq) {
		this.gradeSeq = gradeSeq;
		return this;
	}
	public int getMbCash() {
		return mbCash;
	}
	public MemberVo setMbCash(int mbCash) {
		this.mbCash = mbCash;
		return this;
	}
	public int getMbPoint() {
		return mbPoint;
	}
	public MemberVo setMbPoint(int mbPoint) {
		this.mbPoint = mbPoint;
		return this;
	}
	public String getMbBizAddressDetail() {
		return mbBizAddressDetail;
	}
	public MemberVo setMbBizAddressDetail(String mbBizAddressDetail) {
		this.mbBizAddressDetail = mbBizAddressDetail;
		return this;
	}
}
