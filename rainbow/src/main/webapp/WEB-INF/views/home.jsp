<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
	<script type="text/javascript" src="/js/common/jquery-3.2.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
function ajaxTest(){
	
	
	var param = {
		"textData" : $("#textData").val()
	}
	
	$.ajax({
			type : "POST"
			,url : "/testUpdateAjax.do"
			,data : param
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				$("#pp").text(result.result);
				console.log("success");
				console.log(result);
				console.log(status);
				console.log(xhr);
			}
			,error : function(jqXHR, textStatus, errorThrown) {
				console.log("error");
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}
</script>
<h1>
	Hello world!   
</h1>	
<form action="/testUpdate.do" method="post">
	<input type="text" name="textData" id="textData">
	<input type="submit" value="전송">
</form>

<button onclick="ajaxTest();">ajax테스트</button>
	
<form action="/testValid.do" method="post">
	<input type="text" name="menuId">
	<input type="text" name="menuName">
	<input type="text" name="menuOrder">
	<input type="text" name="menuLink">
	<input type="text" name="menuRegUser">
	<input type="submit" value="valid check!">
</form>

<P>  The time on the server is ${serverTime}.  </P>
<P id="pp"> ${result }</P>
<P> ${testVo.menuId }</P>
<P> ${testVo.menuName }</P>
<P> ${testVo.menuOrder }</P>
<P> ${testVo.menuLink }</P>
<P> ${testVo.menuRegUser }</P>
</body>
</html>
