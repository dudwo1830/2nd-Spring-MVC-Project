<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/changeNick.css?ver=4">
<body>
<form name="changeNick" method="POST" autocomplete="off">
<input type="hidden" name="uid" value="${userDTO.uid }">
	<div class="changeNick_body">
		<div class=""><span class=""></span></div>
		<div class="changeNick_body_changeNick">
			<div class="changeNick_div_1"><input class="changeNick_input unickname" id="checknick" type="text" name="unickname"
					maxlength="10" oninput="checkNick()" placeholder="닉네임" onkeyup="enterkey()">
			</div>
			<div class="changeNick_div_2"><span class="nick">변경할 닉네임을 입력해주세요</span></div>
			<div class="changeNick_div_1">
				<input class="changeNick_submit" id="submit" type="submit" onclick="send()" value="확인"
					disabled="disabled">
			</div>
		</div>
	</div>
</form>
<script>
	var nickCheck = 0;
	
	function checkNick(){
		var inputed = $('.unickname').val();
		console.log(inputed);
		if(inputed != "" && inputed.length >= 2){
			$(".unickname").css("background-color", "#B0F6AC");
			$(".changeNick_div_2 .nick").text("사용할 수 있는 닉네임입니다");
			$(".changeNick_div_2 .nick").attr("style", "color:#00f");
			nickCheck = 1;
			if(nickCheck == 1){
				$("#submit").prop("disabled", false);
				$("#submit").css("background-color", "#4CAF50");
			}
		}else{
			nickCheck = 0;
			$("#submit").prop("disabled", true);
			$("#submit").css("background-color", "#aaaaaa");
			$(".unickname").css("background-color", "#FFCECE");
			$(".changeNick_div_2 .nick").attr("style", "color:#f00");
			if(inputed.length < 2){
				$(".changeNick_div_2 .nick").text("닉네임은 2자리이상 입력해주세요");
			}else if(inputed == ""){
				$(".changeNick_div_2 .nick").text("변경할 닉네임을 입력해주세요");
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