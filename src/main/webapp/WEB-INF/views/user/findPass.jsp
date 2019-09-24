<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/findPass.css?ver=3">
<body>
<form name="findPass" method="post" autocomplete="off">
	<div class="findPass_body">
		<div class=""><span class=""></span></div>
		<div class="findPass_body_findPass">
			<div class="findPass_div_1"><input class="findPass_input uid" id="checkem" type="email" name="uid" maxlength="40"
					oninput="checkId()" onkeyup="enterkey()" placeholder="이메일">
			</div>
			<div class="findPass_div_1"><span class="email">이메일을 입력해주세요</span></div>
			<div class="findPass_div_1">
				<input class="findPass_submit" id="submit" type="submit" onclick="send()" disabled="disabled" value="확인">
			</div>
		</div>
	</div>
</form>
<script>
	var idCheck = 0;
	
	function checkId(){
		var inputed = $('.uid').val();
		console.log(inputed);
		$.ajax({
			data : {
				uid : inputed
			},
			url : "/user/idCheck",
			success : function(data){
				if(inputed == "" && data == '0'){
					$("#submit").prop("disabled", true);
					$("#submit").css("background-color", "#aaaaaa");
					$("#checkem").css("background-color", "#FFCECE");
					$(".findPass_div_1 .email").text("이메일을 입력해주세요");
					$(".findPass_div_1 .email").attr("style", "color:#f00");
					idCheck = 0;
				}else if(data == '1'){
					$("#checkem").css("background-color", "#B0F6AC");
					$(".findPass_div_1 .email").text("");
					idCheck = 1;
					if(idCheck = 1){
						$("#submit").prop("disabled", false);
						$("#submit").css("background-color", "#4CAF50");
					}
				}else if(data == '0'){
					$("#submit").prop("disabled", true);
					$("#submit").css("background-color", "#aaaaaa");
					$("#checkem").css("background-color", "#FFCECE");
					$(".findPass_div_1 .email").text("존재하지 않는 이메일입니다");
					$(".findPass_div_1 .email").attr("style", "color:#f00");
					idCheck = 0;
				}
			}
		});
	}
	function enterkey(){
		if(window.event.keyCode == 13){
			send();
		}
	}
</script>
</body>
</html>