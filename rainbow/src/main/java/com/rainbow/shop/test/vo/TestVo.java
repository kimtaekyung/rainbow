package com.rainbow.shop.test.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;


public class TestVo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	//에노테이션 옵션 정리.
	//@AssertFalse : false 값만 통과 가능
	//@AssertTrue : true 값만 통과 가능
	//@DecimalMax(value=) : 지정된 값 이하의 실수만 통과 가능
	//@DecimalMin(value=) : 지정된 값 이상의 실수만 통과 가능
	//@Digits(integer=,fraction=) : 대상 수가 지정된 정수와 소수 자리수보다 적을 경우 통과 가능
	//@Future : 대상 날짜가 현재보다 미래일 경우만 통과 가능
	//@Past : 대상 날짜가 현재보다 과거일 경우만 통과 가능
	//@Max(value) : 지정된 값보다 아래일 경우만 통과 가능
	//@Min(value) : 지정된 값보다 이상일 경우만 통과 가능
	//@NotNull : null 값이 아닐 경우만 통과 가능
	//@Null : null일 겨우만 통과 가능
	//@Pattern(regex=, flag=) : 해당 정규식을 만족할 경우만 통과 가능
	//@Size(min=, max=) : 문자열 또는 배열이 지정된 값 사이일 경우 통과 가능
	//@Valid : 대상 객체의 확인 조건을 만족할 경우 통과 가능
	
	
	@NotNull
	private String menuId;
	@NotNull
	private String menuName;
	@NotNull
	private int menuOrder;
	@NotNull
	private String menuLink;
	@NotNull
	private String menuRegUser;
	
	private String menuRegDttm;
	
	public String getMenuId() {
		return menuId;
	}
	public TestVo setMenuId(String menuId) {
		this.menuId = menuId;
		return this;
	}
	public String getMenuName() {
		return menuName;
	}
	public TestVo setMenuName(String menuName) {
		this.menuName = menuName;
		return this;
	}
	public int getMenuOrder() {
		return menuOrder;
	}
	public TestVo setMenuOrder(int menuOrder) {
		this.menuOrder = menuOrder;
		return this;
	}
	public String getMenuLink() {
		return menuLink;
	}
	public TestVo setMenuLink(String menuLink) {
		this.menuLink = menuLink;
		return this;
	}
	public String getMenuRegUser() {
		return menuRegUser;
	}
	public TestVo setMenuRegUser(String menuRegUser) {
		this.menuRegUser = menuRegUser;
		return this;
	}
	public String getMenuRegDttm() {
		return menuRegDttm;
	}
	public TestVo setMenuRegDttm(String menuRegDttm) {
		this.menuRegDttm = menuRegDttm;
		return this;
	}
	
	
	@Override
	public String toString() {
		return "TestVo [menuId=" + menuId + ", menuName=" + menuName + ", menuOrder=" + menuOrder + ", menuLink="
				+ menuLink + ", menuRegUser=" + menuRegUser + "]";
	} 
	
}
