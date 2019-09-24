<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css?ver=8">
<body>
<form name="loginPOST" action="loginPOST" method="POST" autocomplete="on">
	<div class="login_body">
		<div class=""><span class=""></span></div>
		<div class="login_body_login">
			<div class="login_div_1">
				<span class="login_status"></span>
			</div>
			<div class="login_div_1"><input class="login_input uid" type="email" name="uid" maxlength="40"
					placeholder="이메일">
			</div>
			<div class="login_div_1"><input class="login_input upw" type="password" name="upw" maxlength="20"
					placeholder="1234" onkeyup="enterkey()">
			</div>
			<div class="login_div_sav"><label>
				<span class="login_sav">아이디 저장</span>
				<input class="login_checkbox" type="checkbox" id="uid_sav">
			</label></div>
			<div class="login_div_1">
				<input class="login_submit" type="button" onclick="checkId()" value="로그인">
			</div>
			<div class="login_div_2">
				<span class="login_span">
					<a class="login_a1" href="/user/join">회원가입</a>
					<a class="login_a2" href="/user/findPass">비밀번호찾기</a>
				</span>
			</div>
		</div>
	</div>
</form>
<script>
	//ajax
	var idCheck = 0;
	var pwdCheck = 0;
	
	function checkId(){
		var inputed = $('.uid').val();
		var inputed2 = $('.upw').val();
		console.log(inputed);
		console.log(inputed2);
		$.ajax({
			data : {
				uid : inputed,
				upw : inputed2
			},
			url : "/user/login_check",
			success : function(data){
				if(data == '0'){
					if((inputed == "" || inputed2 == "") && data == '0'){
						if(inputed == "" && inputed2 != ""){
							$(".login_status").text("이메일을 입력해주세요");
							$(".login_status").attr("style", "color:#f00");
						}else if(inputed2 == "" && inputed != ""){
							$(".login_status").text("비밀번호를 입력해주세요");
							$(".login_status").attr("style", "color:#f00");
						}
					}else{
						$(".login_status").text("이메일 또는 비밀번호를 다시 확인해주세요");
						$(".login_status").attr("style", "color:#f00");
					}
				}else if(data == '2'){
					alert("인증되지 않은 이메일입니다. \n 인증후 이용해주세요");
					location.href = '../';
				}else if(data == '1'){
					document.loginPOST.submit();
				}
			}
		});
	}
	//엔터키
	function enterkey(){
		if(window.event.keyCode == 13){
			checkId();
		}
	}
	//쿠키를 이용한 아이디 저장
	$(document).ready(function(){
		var cookieName = getCookie("cookieName");
		$("input[name = 'uid']").val(cookieName);
		
		if($("input[name = 'uid']").val() != ""){
			$("#uid_sav").attr("checked", true);
		}
		
		$("#uid_sav").change(function(){
			if($("#uid_sav").is(":checked")){				//ID 저장하기 체크시
				var cookieName = $("input[name = 'uid']").val();	
				setCookie("cookieName", cookieName, 7);	//쿠키 7일동안 보관
			}else{			//ID 저장하기 체크 해제 시
				deleteCookie("cookieName");	//쿠키 삭제
			}
		});
		//ID 저장하기를 체크한 상태에서 ID를 입력하는 경우
		$("input[name = 'uid']").keyup(function(){	//ID 입력칸에 ID를 입력할때
			if($("#uid_sav").is(":checked")){		//ID 저장하기가 체크상태라면
				var cookieName = $("input[name = 'uid']").val();
				setCookie("cookieName", cookieName, 7);	//7일동안 쿠키 보관
			}
		});
	});
	
	function setCookie(cookieName, value, exdays){
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires = "+ exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}
	
	function deleteCookie(cookieName){
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= "+ "; expires" + expireDate.toGMTString();
	} 
	function getCookie(cookieName){
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if(start != -1){
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if(end == -1)end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>
</body>
</html>