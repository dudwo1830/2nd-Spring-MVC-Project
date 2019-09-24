<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" href="/resources/css/cloud.css">
<div class="P2PBody">
	<div class="searchP2P">
		<select id="searchCate" name="searchType" onchange="inputedCate(); checkSearch();">
			<option value="coriginName" selected="selected">파일명</option>
			<option value="cuid">이메일</option>
			<option value="cunickName">닉네임</option>
		</select>
		<input id="searchKey" name="keyword" placeholder="검색" oninput="inputedKeyword(); checkSearch();">
	</div>
	<input id="checkUpload" type="hidden" value="" >
		<table class="listP2P scrollLocation">
			<tr>
				<td class="tdShort">번호</td>
				<td>파일종류</td>
				<td class="tdRarge">파일명</td>
				<td class="tdShort">닉네임</td>
				<td class="tdMiddle">이메일</td>
				<td class="tdShort">용량</td>
				<td class="tdMiddle">업로드일자</td>
			</tr>
		<c:forEach var="list" items="${listMy}" varStatus="index">
		<c:set var="link" value="/resources/upload/${list.cfileName }"/>
		<fmt:formatNumber var="downloadPt" value="${((list.cfileSize/1024/1024)+(1-((list.cfileSize/1024/1024)%1))%1)*100}" pattern="###" type="number"/>
		<c:set var="uploadId" value="${list.cuid }"/>
			<tr class="defaultList">
				<td class="scrolling" data-cid="${list.cid}">${list.cid}</td>
				<td>
					<c:choose>
					<c:when test="${list.ext == 'jpg' || list.ext == 'png' || list.ext == 'gif' || list.ext == 'jpeg'}">
						<img title="이미지파일" src="/resources/img/picture.png">
					</c:when>
					<c:when test="${list.ext == 'exe'}">
						<img title="실행파일" src="/resources/img/exe.png">
					</c:when>
					<c:when test="${list.ext == 'log' || list.ext == 'doc' || list.ext == 'pdf' || list.ext == 'txt' || list.ext == 'js'}">
						<img title="문서파일" src="/resources/img/text.png">
					</c:when>
					<c:when test="${list.ext == 'zip' || list.ext == 'rar' || list.ext == 'egg' || list.ext == '7z'}">
						<img title="압축파일" src="/resources/img/zip.png">
					</c:when>
					<c:when test="${list.ext == 'lnk'}">
						<img title="바로가기파일" src="/resources/img/lnk.png">
					</c:when>
					<c:when test="${list.ext == 'mp3' || list.ext == 'wma' || list.ext == 'ogg' || list.ext == 'flac' }">
						<img title="음악파일" src="/resources/img/music.png">
					</c:when>
					<c:when test="${list.ext == 'mp4' || list.ext == 'avi' || list.ext == 'mkv'}">
						<img title="동영상파일" src="/resources/img/video.png">
					</c:when>
					<c:otherwise>
						<img title="기타파일" src="/resources/img/file.png">
					</c:otherwise>
					</c:choose>
				</td>
				<td id="trans" class="title"><a onclick="fileDown('${uploadId}', ${downloadPt}, '${list.cfileName }')">
					<c:choose>
					<c:when test="${fn:length(list.coriginName) > 40}">
						<c:out value="${fn:substring(list.coriginName,0,39)}"/>...
					</c:when>
					<c:otherwise>
						<c:out value="${list.coriginName}"></c:out>
					</c:otherwise>
					</c:choose>
				</a></td>
				<td>
					<c:choose>
					<c:when test="${fn:length(list.cunickName) > 10}">
						<c:out value="${fn:substring(list.cunickName,0,9)}"/>...
					</c:when>
					<c:otherwise>
						<c:out value="${list.cunickName }"></c:out>
					</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
					<c:when test="${fn:length(list.cuid) > 20}">
						<c:out value="${fn:substring(list.cuid,0,19)}"/>...
					</c:when>
					<c:otherwise>
						<c:out value="${list.cuid }"></c:out>
					</c:otherwise>
					</c:choose>
				<td>
					<c:choose>
					<c:when test="${list.cfileSize > 1000*1024 }">
						<fmt:formatNumber value="${list.cfileSize/1024/1024 }" pattern="###.##"/>MB
					</c:when>
					<c:otherwise>
						<fmt:formatNumber value="${list.cfileSize/1024 }" pattern="###.##"/>KB
					</c:otherwise>
					</c:choose>
				</td>
				<td><fmt:formatDate value="${list.cdate }" pattern="yyyy-MM-dd HH:mm"/></td>
				<c:if test="${index.last }">
					<c:set var="lastCnt" value="${index.index}"/>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</div>
<script type="text/javascript">
var uid = '${userDTO.uid}';
var upoint = '${userDTO.upoint}';
var lastCnt = ${lastCnt};
console.log("lastCnt : "+lastCnt);
var inputKeyword = "";
var inputCate = "";
function inputedKeyword(){
	inputKeyword = $('#searchKey').val();
	console.log(inputKeyword);
}
function inputedCate(){
	inputCate = $("select[name=searchType]").val();
	console.log(inputCate);
}
//다운로드시
function fileDown(upUid, downPoint, link){
	if(uid != '' && uid != null){	
		var createA = document.createElement('a');
		createA.setAttribute('href', "/resources/upload/"+link);
		createA.setAttribute('download', link);
		console.log(createA);
		swal({
			title: "주의",
			text: "파일 다운로드시 1MB당 100포인트, 올림\n ="+downPoint+" 포인트가 차감됩니다.\n 자신이 올린 파일은 포인트차감이 되지 않습니다.\n(다운로드에 필요한 포인트는 필요합니다.)",
			icons: "warning",
			buttons: ["취소", "다운로드"],
		}).then((Yes) =>{
			if(Yes){
				if(upoint < downPoint){
					swal({
						title: "포인트부족",
						text: "가지고있는 포인트가 필요한 포인트보다 작을경우",
						icons: "error"
					});
					return false;
				}
				createA.click();
				$.ajax({
					type: 'POST',
					url: "/user/userDownload",
					data: {
						downloadUid : uid,
						uploadUid : upUid,
						downloadPt : downPoint
					}
				});//ajax END
			}//if(Yes) END
		});//swal END
	}//if(uid)END
	else{
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
//새로고침시 스크롤바 맨 위로
window.onload = function(){
	setTimeout(function(){
		scrollTo(0,0);
	}, 100);
}
//업로드 상태바 숨김
function timeHide(){
	document.getElementById("statusBody").style.display = "none";
}

//timeStamp 포맷
function date_to_str(format){
	var year = format.getFullYear();
	var month = format.getMonth() + 1;
	if(month < 10) month = '0' + month;
	var date = format.getDate();
	if(date < 10) date = '0' + date;
	var hour = format.getHours();
	if(hour < 10) hour = '0' +	hour;
	var min = format.getMinutes();
	if(min < 10) min = '0' + min;
	
	return year+"-"+month+"-"+date+" " +hour+":"+min;
}
//스크롤 페이징
//[https://wjheo.tistory.com/entry/Spring-페이지-무한스크롤]
//이전스크롤 좌표 기본값은 최초의 0
var lastScrollTop = 0;
//스크롤 이벤트
$(window).scroll(function(){
	//현재 스크롤 좌표
	var currentScrollNow = $(window).scrollTop();
	console.log("currentScrollNow : "+currentScrollNow);
	//다운 스크롤
	if(currentScrollNow - lastScrollTop > 0){
		console.log("down-scroll");
		//이전 스크롤 좌표 = 현재 스크롤 좌표
		lastScrollTop = currentScrollNow;
		console.log("lastScrollTop : "+lastScrollTop);
		if($(window).scrollTop() >= ($(document).height() - $(window).height())){
			//다음 게시물을 불러올 cid
			var lastcid = $(".scrolling:last").attr("data-cid");
			
			console.log('lastCnt in scroll ajax : '+lastCnt);
			//ajax로 서버에 데이터 요청
			$.ajax({
				type : 'post',
				url : '/cloud/nextListAll',
				data : ({	//서버로 보낼 데이터
					cid : lastCnt,
					cate : inputCate,
					keyword : inputKeyword
				}),
				//ajax가 성공했을때 실행될 function
				//이때의 data는 되돌려받은 json data임
				success : function(data){
					var str = "";
					console.log(data);
					//받아온 데이터가 null이거나 ""이 아닌경우 핸들링
						if(data != "" || data != null){
							//data가 list이므로 each를 사용
							$(data).each(
								function(){
									lastCnt = lastCnt + 1;
									var cdate = date_to_str(new Date(this.cdate));
									console.log(this);
									var cfileSize = this.cfileSize;
									var cunickName = this.cunickName;
									var cuid = this.cuid;
									var coriginName = this.coriginName;
									console.log(cfileSize);
									if(cfileSize > 1000*1024){
										cfileSize = (cfileSize/(1024*1024)).toFixed(2)+'MB';
									}else{
										cfileSize = (cfileSize/1024).toFixed(2)+'KB';
									}
									if(cunickName.length > 10){
										cuickName = cunickName.substring(0, 9)+"...";
									}
									if(cuid.length > 20){
										cuid = cuid.substring(0, 19)+"...";
									}
									if(coriginName.length > 40){
										coriginName = coriginName.substring(0, 39)+"...";
									}
									var ext = this.ext;
									var extImg = "";
									if(ext == 'jpg' || ext == 'png' || ext == 'gif' || ext == 'jpeg'){
										extImg = "<img title='이미지파일' src='/resources/img/picture.png'>";
									}else if(ext == 'log' || ext == 'txt' || ext == 'doc' || ext == 'pdf' || ext == 'js'){
										extImg = "<img title='문서파일' src='/resources/img/text.png'>";
									}else if(ext == 'zip' || ext == 'rar' || ext == 'egg' || ext == '7z'){
										extImg = "<img title='압축파일' src='/resources/img/zip.png'>";
									}else if(ext == 'mp3' || ext == 'wma' || ext == 'ogg' || ext == 'flac'){
										extImg = "<img title='음악파일' src='/resources/img/music.png'>";
									}else if(ext == 'mp4' || ext == 'avi' || ext == 'mkv'){
										extImg = "<img title='동영상파일' src='/resources/img/video.png'>";
									}else if(ext == 'lnk'){
										extImg = "<img title='바로가기파일' src='/resources/img/lnk.png'>";
									}else if(ext == 'exe'){
										extImg = "<img title='실행파일' src='/resources/img/exe.png'>";
									}else{
										extImg = "<img title='기타파일' src='/resources/img/file.png'>";
									}
									var nextDlPt = 0;
									var supCfileName = this.cfileName;
									nextDlPt = (Math.ceil(this.cfileSize/1024/1024))*100;
									console.log("다운로드 포인트 : "+nextDlPt);
									str +=	"<tr class='scrollLocation2'>"
										+		"<td class='scrolling'>"+this.cid+"</td>"
										+		"<td>"+extImg+"</td>"
										+		"<td id='trans' class='title'>"
										+			"<a onclick=\"fileDown("+nextDlPt+", '"+supCfileName+"')\">"
										+			coriginName+"</a></td>"
										+		"<td>"+cunickName+"</td>"
										+		"<td>"+cuid+"</td>"
										+		"<td>"+cfileSize+"</td>"
										+		"<td>"+cdate+"</td>"
										+	"</tr>";
								}//function END
							);//each END
							//이전까지 뿌려졌던 데이터를 비우고, str을 뿌림
							console.log("lastCnt : "+lastCnt);
							console.log("lastcid : "+lastcid);
							$(".scrollLocation").append(str);
						}//if data != '' END
					},
					error : function(request,error){
						console.log("message:"+request.responseText);
					}
				}//Success function END
			);//ajax END
		}//if END
	}//DOM핸들링
});
//검색
function checkSearch(){
	lastScrollTop = 0;
	var inputed = inputKeyword;
	var inputed2 = inputCate;
	if(inputed2 == ""){
		inputed2 = "coriginName";
	}
	console.log(inputed);
	$.ajax({
		data:{
			keyword : inputed,
			cate : inputed2
		},
		url : "/cloud/searchList",
		success : function(data){
			var str = "";
			console.log("data : "+data);
			if(data != null && data != ""){
				if(inputed != null && inputed != ""){
					console.log("검색 내용이 있을경우");
					lastCnt = 0;
					$(".defaultList").hide();	//초기 리스트 숨김
					$(".scrollLocation2").empty();		//기존 검색리스트 제거
					$(data).each(function(){
						console.log("lastCnt : "+lastCnt);
						lastCnt = lastCnt + 1;
						var cdate = date_to_str(new Date(this.cdate));	//date_to_str 날짜 포맷 변경
						var cunickName = this.cunickName;
						var cfileSize = this.cfileSize;
						var coriginName = this.coriginName;
						var cuid = this.cuid;
						console.log(cfileSize);
						if(cfileSize/4 > 1000*1024){
							cfileSize = (cfileSize/(1024*1024)).toFixed(2)+'MB';
						}else{
							cfileSize = (cfileSize/1024).toFixed(2)+'KB';
						}
						if(cunickName.length > 10){
							cuickName = cunickName.substring(0, 9)+"...";
						}
						if(cuid.length > 20){
							cuid = cuid.substring(0, 19)+"...";
						}
						if(coriginName.length > 40){
							coriginName = coriginName.substring(0, 39)+"...";
						}
						var nextDlPt = 0;
						var supCfileName = this.cfileName;
						var ext = this.ext;
						var extImg = "";
						if(ext == 'jpg' || ext == 'png' || ext == 'gif' || ext == 'jpeg'){
							extImg = "<img title='이미지파일' src='/resources/upload/"+this.cfileName+"'>";
						}else if(ext == 'log' || ext == 'txt' || ext == 'doc' || ext == 'pdf' || ext == 'js'){
							extImg = "<img title='문서파일' src='/resources/img/text.png'>";
						}else if(ext == 'zip' || ext == 'rar' || ext == 'egg' || ext == '7z'){
							extImg = "<img title='압축파일' src='/resources/img/zip.png'>";
						}else if(ext == 'mp3' || ext == 'wma' || ext == 'ogg' || ext == 'flac'){
							extImg = "<img title='음악파일' src='/resources/img/music.png'>";
						}else if(ext == 'mp4' || ext == 'avi' || ext == 'mkv'){
							extImg = "<img title='동영상파일' src='/resources/img/video.png'>";
						}else if(ext == 'lnk'){
							extImg = "<img title='바로가기파일' src='/resources/img/lnk.png'>";
						}else if(ext == 'exe'){
							extImg = "<img title='실행파일' src='/resources/img/exe.png'>";
						}else{
							extImg = "<img title='기타파일' src='/resources/img/file.png'>";
						}
					str +=	"<tr class='scrollLocation2'>"
						+		"<td class='scrolling'>"+this.cid+"</td>"
						+		"<td>"+extImg+"</td>"
						+		"<td id='trans' class='title'>"
						+			"<a onclick=\"fileDown('"+cuid+"', "+nextDlPt+", '"+supCfileName+"')\">"
						+			coriginName+"</a></td>"
						+		"<td>"+cunickName+"</td>"
						+		"<td>"+cuid+"</td>"
						+		"<td>"+cfileSize+"</td>"
						+		"<td>"+cdate+"</td>"
						+	"</tr>";
					});//each END
					$(".scrollLocation").append(str);
				}//if inputed END
			}//if data END
			else{
				if(inputed == null || inputed == ""){
					console.log("검색 내용이 없을경우");
					var status = $("#defaultList").css("display");
					console.log("display : "+status);
					$(".scrollLocation2").empty();	//검색했던 내용 제거
					$(".defaultList").show();	//숨겼던거 다시 불러옴
					lastCnt = ${lastCnt};
				}else{
					$(".scrollLocation2").empty();
					$(".defaultList").hide();	//초기 리스트 숨김
					swal({
						title: "경고",
						text: "일치하는 데이터가 없습니다",
						icon: "warning"
					});
				}
			}
		}//success END
	});//ajax END
}
</script>
</body>
</html>