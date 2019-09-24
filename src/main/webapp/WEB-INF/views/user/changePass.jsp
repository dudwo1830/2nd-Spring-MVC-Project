<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/changePass.css?ver=4">
<body>
<form name="changePass" method="POST" autocomplete="off">
<input type="hidden" name="authkey" value="${userDTO.authkey }">
	<div class="changePass_body">
		<div class=""><span class=""></span></div>
		<div class="changePass_body_changePass">
			<div class="changePass_div_1"><input class="changePass_input upw" id="checkpw" type="password" name="upw"
					maxlength="20" oninput="checkPwd()" placeholder="비밀번호">
			</div>
			<div class="changePass_div_2"><span class="pass">변경할 비밀번호를 입력해주세요</span></div>
			<div class="changePass_div_1"><input class="changePass_input upw_re" id="checkpw_re" type="password" name="upw_re"
					maxlength="20" oninput="checkPwd()" placeholder="비밀번호 재입력">
			</div>
			<div class="changePass_div_2"><span class="pass_re">비밀번호를 다시 입력해주세요</span></div>
			<div class="changePass_div_1">
				<input class="changePass_submit" id="submit" type="submit" onclick="send()" value="확인"
					disabled="disabled">
			</div>
		</div>
	</div>
</form>
<script>
	var pwdCheck = 0;
	
	function checkPwd(){
		var inputed = $('.upw').val();
		var reinputed = $('.upw_re').val();
		console.log(inputed);
		console.log(reinputed);
		if(inputed == "" || reinputed == ""){
			$("#submit").prop("disabled", true);
			$("#submit").css("background-color", "#aaaaaa");
			$(".upw").css("background-color", "#FFCECE");
			$(".upw_re").css("background-color", "#FFCECE");
			$(".changePass_div_2 .pass").text("비밀번호를 입력해주세요");
			$(".changePass_div_2 .pass").attr("style", "color:#f00");
			$(".changePass_div_2 .pass_re").text("비밀번호를 다시 입력해주세요");
			$(".changePass_div_2 .pass_re").attr("style", "color:#f00");
		}else if(inputed != "" && reinputed != "" && inputed == reinputed){
			$(".changePass_div_2 .pass").text("비밀번호가 일치합니다");
			$(".changePass_div_2 .pass").attr("style", "color:#00f");
			$(".upw").css("background-color", "#B0F6AC");
			$(".changePass_div_2 .pass_re").text("비밀번호가 일치합니다");
			$(".changePass_div_2 .pass_re").attr("style", "color:#00f");
			$(".upw_re").css("background-color", "#B0F6AC");
			pwdCheck = 1;
			if(pwdCheck = 1){
				$("#submit").prop("disabled", false);
				$("#submit").css("background-color", "#4CAF50");
			}
		}else if(inputed != "" && reinputed != "" && inputed != reinputed){
			pwdCheck = 0;
			$("#submit").prop("disabled", true);
			$("#submit").css("background-color", "#aaaaaa");
			$(".upw").css("background-color", "#FFCECE");
			$(".changePass_div_2 .pass").text("비밀번호가 일치하지 않습니다");
			$(".changePass_div_2 .pass").attr("style", "color:#f00");
			$(".upw_re").css("background-color", "#FFCECE");
			$(".changePass_div_2 .pass_re").text("비밀번호가 일치하지 않습니다");
			$(".changePass_div_2 .pass_re").attr("style", "color:#f00");
		}
	}
	function enterkey(){
		if(window.event.keyCode == 13){
			send();
		}
	}
</script>
</body>
</html>