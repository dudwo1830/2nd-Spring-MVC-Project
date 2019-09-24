<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/join.css?ver=2">
<body>
<form name="join" action="join_send" method="POST" autocomplete="off">
	<div class="join_body" id="idCheck">
		<div class=""><span class=""></span></div>
		<div class="join_body_join">
			<div class="join_div_1"><input class="join_input uid" id="checkem" name="uid" type="email"
					maxlength="40" oninput="checkId()" placeholder="이메일">
			</div>
			<div class="join_div_2"><span class="email">이메일을 입력해주세요</span></div>
			<div class="join_div_1"><input class="join_input upw" id="checkpw" type="password" name="upw"
					maxlength="20" oninput="checkPwd()" placeholder="비밀번호">
			</div>
			<div class="join_div_2"><span class="pass">비밀번호를 입력해주세요</span></div>
			<div class="join_div_1"><input class="join_input upw_re" id="checkpw_re" type="password" name="upw_re"
					maxlength="20" oninput="checkPwd()" placeholder="비밀번호 재입력">
			</div>
			<div class="join_div_2"><span class="pass_re">비밀번호를 다시 입력해주세요</span></div>
			<div class="join_div_1"><input class="join_input unickname" id="checknick" type="text" name="unickname"
					maxlength="10" oninput="checkNick()" placeholder="닉네임" onkeyup="enterkey()">
			</div>
			<div class="join_div_2"><span class="nick">닉네임을 입력해주세요</span></div>
			<div class="join_div_1">
				<div class="join_div_half"><input class="join_home" type="button" value="홈으로"
						onclick="location.href='/'"></div>
				<div class="join_div_half"><input class="join_submit" id="submit" type="submit" 
					onclick="send()" disabled="disabled" value="가입하기">
				</div>
			</div>
		</div>
	</div>
</form>
<script>
	var check_email = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	var idCheck = 0;
	var nickCheck = 0;
	var pwdCheck = 0;
	
	function checkId(){
		var inputed = $('.uid').val();
		console.log(inputed);
		$.ajax({
			data : {
				uid : inputed
			},
			url : "/user/idCheck",
			success : function(data){
				var a = check_email.test(inputed);
				if(inputed == "" && data == '0'){
					$("#submit").prop("disabled", true);
					$("#submit").css("background-color", "#aaaaaa");
					$("#checkem").css("background-color", "#FFCECE");
					$(".join_div_2 .email").text("이메일을 입력해주세요");
					$(".join_div_2 .email").attr("style", "color:#f00");
					idCheck = 0;
				}else if(data == '0'){
					if(a == false){
						$("#submit").prop("disabled", true);
						$("#submit").css("background-color", "#aaaaaa");
						$("#checkem").css("background-color", "#FFCECE");
						$(".join_div_2 .email").text("이메일형식에 맞지 않습니다");
						$(".join_div_2 .email").attr("style", "color:#f00");
						idCheck = 0;
					}else{
						$("#checkem").css("background-color", "#B0F6AC");
						$(".join_div_2 .email").text("사용가능한 이메일입니다.");
						$(".join_div_2 .email").attr("style", "color:#00f");
						idCheck = 1;
						if(pwdCheck == 1 && nickCheck == 1){
							$("#submit").prop("disabled", false);
							$("#submit").css("background-color", "#4CAF50");
						}
					}
				}else if(data == '1'){
					$("#submit").prop("disabled", true);
					$("#submit").css("background-color", "#aaaaaa");
					$("#checkem").css("background-color", "#FFCECE");
					$(".join_div_2 .email").text("이미 사용중인 이메일입니다.");
					$(".join_div_2 .email").attr("style", "color:#f00");
					idCheck = 0;
				}
			}
		});
	}
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
			$(".join_div_2 .pass").text("비밀번호를 입력해주세요");
			$(".join_div_2 .pass").attr("style", "color:#f00");
			$(".join_div_2 .pass_re").text("비밀번호를 다시 입력해주세요");
			$(".join_div_2 .pass_re").attr("style", "color:#f00");
		}else if(inputed != "" && reinputed != "" && inputed == reinputed){
			$(".join_div_2 .pass").text("비밀번호가 일치합니다");
			$(".join_div_2 .pass").attr("style", "color:#00f");
			$(".upw").css("background-color", "#B0F6AC");
			$(".join_div_2 .pass_re").text("비밀번호가 일치합니다");
			$(".join_div_2 .pass_re").attr("style", "color:#00f");
			$(".upw_re").css("background-color", "#B0F6AC");
			pwdCheck = 1;
			if(idCheck == 1 && nickCheck == 1){
				$("#submit").prop("disabled", false);
				$("#submit").css("background-color", "#4CAF50");
			}
		}else if(inputed != "" && reinputed != "" && inputed != reinputed){
			pwdCheck = 0;
			$("#submit").prop("disabled", true);
			$("#submit").css("background-color", "#aaaaaa");
			$(".upw").css("background-color", "#FFCECE");
			$(".join_div_2 .pass").text("비밀번호가 일치하지 않습니다");
			$(".join_div_2 .pass").attr("style", "color:#f00");
			$(".upw_re").css("background-color", "#FFCECE");
			$(".join_div_2 .pass_re").text("비밀번호가 일치하지 않습니다");
			$(".join_div_2 .pass_re").attr("style", "color:#f00");
		}
	}
	function checkNick(){
		var inputed = $('.unickname').val();
		console.log(inputed);
		if(inputed != "" && inputed.length >= 2){
			$(".unickname").css("background-color", "#B0F6AC");
			$(".join_div_2 .nick").text("사용할 수 있는 닉네임입니다");
			$(".join_div_2 .nick").attr("style", "color:#00f");
			nickCheck = 1;
			if(idCheck == 1 && pwdCheck == 1){
				$("#submit").prop("disabled", false);
				$("#submit").css("background-color", "#4CAF50");
			}
		}else{
			nickCheck = 0;
			$("#submit").prop("disabled", true);
			$("#submit").css("background-color", "#aaaaaa");
			$(".unickname").css("background-color", "#FFCECE");
			$(".join_div_2 .nick").attr("style", "color:#f00");
			if(inputed.length < 2){
				$(".join_div_2 .nick").text("닉네임은 2자리이상 입력해주세요");
			}else if(inputed == ""){
				$(".join_div_2 .nick").text("닉네임을 입력해주세요");
			}
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