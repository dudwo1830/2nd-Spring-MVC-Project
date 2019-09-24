<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEMP</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/combine/npm/purecss@1.0.1/build/base-min.css,npm/purecss@1.0.1/build/grids-min.css,npm/purecss@1.0.1/build/forms-min.css">
</head>
<link rel="stylesheet" href="/resources/css/head.css?ver=10">
<body>
<c:set var="sessionId" value="" />
	<c:if test="${userDTO.uad != 'Y' }">
		<div class="ad_width">
		ㅡㅡ 광고란 ㅡㅡ<br>
		</div>
	</c:if>
	<div class="head_body">
		<ul class="all_menu">
			<li><a href="/">홈으로</a></li>
		<c:choose>
		<c:when test="${userDTO.uid == null || userDTO.uid == '' }">
			<li><a href="#">Guest</a>
				<ul>
					<li><a href="/user/join" class="documents">회원가입</a></li>
					<li><a href="/user/login" class="signout">로그인</a></li>
				</ul>
			</li>
		</c:when>
		<c:otherwise>
			<li><a href="#">${userDTO.uid }</a>
				<ul>
					<li><a href="#" class="info">
						<span>닉네임</span><br>${userDTO.unickname }
						<br><span>포인트</span><br>${userDTO.upoint }
						<br><span>가입일자</span><br><fmt:formatDate value="${userDTO.ujoindate }" pattern="yy년 MM월 dd일"/>
						<br><span>최근 로그인 일자</span><br><fmt:formatDate value="${userDTO.ulastdate }" pattern="yy년 MM월 dd일"/>
					</a></li>
					<li><a href="/user/changeNick" class="documents">닉네임 변경</a></li>
					<li><a href="/user/changePass" class="documents">비밀번호 변경</a></li>
					<li><a href="/user/logout" class="signout">로그아웃</a></li>
				</ul>
			</li>
		</c:otherwise>
		</c:choose>
			<li style="text-align: center;"><a href="#">Entertainment</a>
				<ul>
					<li><a href="/cloud/myCloud" class="documents">내 클라우드</a></li>
					<li><a href="/cloud/P2P" class="signout">P2P</a></li>
				</ul>
			</li>
			<li style="text-align: center;"><a href="#">Pay</a>
				<ul>
					<li><a href="javascript:void(0);" onclick="payUad();" class="default">광고제거</a></li>
					<li><a href="javascript:void(0);" onclick="payUpoint();" class="default">포인트구입</a></li>
				</ul>
			</li>
		</ul>
		<div>
			<a href="#" class="go_top">TOP</a>
		</div>
    </div>

	<script>
		//맨 위로
		$(document).ready(function(){
			$(window).scroll(function(){
				if($(this).scrollTop() > 200){
					$('.go_top').fadeIn();
				}else{
					$('.go_top').fadeOut();
				}
			});
			$('go_top').click(function(){
				$('html, body').animate({ scrollTop : 0 },400);
				return false;
			});
		});
		//광고제거
		function payUad(){
			var result = confirm("1분동안 광고가 제거되며 10포인트가 차감됩니다.\n 광고를 제거하시겠습니까? ");
			
			if(result == true){
				location.href = '/user/payUad';
			}else{
				return;
			}
		}
		//포인트결제
		function payUpoint(){
			var upointvalue = 0;
			if('${userDTO.uid}' != ''){
				swal({
					title: "포인트추가",
					text: "하시겠습니까",
					icon: "warning",
					buttons: ["NO" , "YES"],
				}).then((willDelete) => {
					if(willDelete){
						swal({
							text: "입력한 숫자의 1%를 적립합니다",
							content: "input",
							button: {
								text: "준다!",
								closeModal: false,
							},
						}).then(upoint =>{
							if(!upoint) throw null;
							if(upoint < 100){
								swal({
									title: "100보다 작은수일때",
									icon: "error"
								});
								throw null;
							}
							if(upoint > 0 && upoint%1 != 0){
								swal({
									title: "소수점이 들어갔을때",
									icon: "error"
								});
								throw null;
							}
							if(isNaN(upoint)){
								swal({
									title: "숫자가 아닐때",
									icon: "error"
								});
								throw null;
							}
							upointvalue = (upoint/100).toString();
							if(upointvalue.substring(0, (upointvalue.length-2)) == ""){
								upointvalue = parseInt(upointvalue);
							}else{
								upointvalue = parseInt(upointvalue.substring(0, (upointvalue.length-2)));
							}
							$.ajax({
								type:'POST',
								url:"/user/payUpoint",
								data: {
									upoint : upointvalue
								}
							});
						}).then(results =>{
							swal({
								title: "감사합니다",
								text: upointvalue+"포인트 추가 성공",
								icon: "success",
							}).then(results =>{
								(function(){
									location.reload();
								});
							})
						}).catch(err =>{
							if(err){
								swal("기타 예외 발생시");
								console.log(err);
							}else{
								swal.stopLoading();
								swal.close();
							}
						});
					}else{
						swal("취소시", {
							icon: "error",
						});
					}
				});
			}else{
				swal({
					title: "로그인이 필요한 서비스입니다",
					text: "로그인하여 이용해주십시오",
					icon: "warning",
				}).then(results =>{
					(function(){
						location.href='/user/login';
					})();
				});
			}
		}
		
	</script>
