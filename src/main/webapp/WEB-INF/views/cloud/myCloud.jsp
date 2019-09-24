<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" href="/resources/css/cloud.css">
<div class="myCloudBody">
	<div class="searchP2P">
		<input id="searchKey" name="keyword" placeholder="파일명검색" oninput="inputedKeyword(); checkSearch();">
	</div>
	<div class="listMyCloud">
		<input id="checkStatus" type="hidden" value="normal" >
		<div id="defaultList">
			<c:forEach var="list" items="${listMy}" varStatus="index">
			<c:set var="link" value="/resources/upload/${list.cfileName }"/>
				<c:choose>
				<c:when test="${list.ext == 'jpg' || list.ext == 'png' || list.ext == 'gif' || list.ext == 'jpeg'}">
					<img src="/resources/upload/${list.cfileName }">
				</c:when>
				<c:when test="${list.ext == 'exe'}">
					<img src="/resources/img/exe.png">
				</c:when>
				<c:when test="${list.ext == 'log' || list.ext == 'doc' || list.ext == 'pdf' || list.ext == 'txt' || list.ext == 'js'}">
					<img src="/resources/img/text.png">
				</c:when>
				<c:when test="${list.ext == 'zip' || list.ext == 'rar' || list.ext == 'egg' || list.ext == '7z'}">
					<img src="/resources/img/zip.png">
				</c:when>
				<c:when test="${list.ext == 'lnk'}">
					<img src="/resources/img/lnk.png">
				</c:when>
				<c:when test="${list.ext == 'mp3' || list.ext == 'wma' || list.ext == 'ogg' || list.ext == 'flac' }">
					<img src="/resources/img/music.png">
				</c:when>
				<c:when test="${list.ext == 'mp4' || list.ext == 'avi' || list.ext == 'mkv'}">
					<img src="/resources/img/video.png">
				</c:when>
				<c:otherwise>
					<img src="/resources/img/file.png">
				</c:otherwise>
				</c:choose>
				<div class="myFiles">
					<p class="title">
						<c:choose>
						<c:when test="${list.coriginName == null || list.coriginName == '' }">
							<span>${list.coriginName = '　'}</span>
						</c:when>					
						<c:otherwise>
							<a href="${link }" download>${list.coriginName }</a>
						</c:otherwise>
						</c:choose>
					</p>
					<p class="scrolling">${list.cid }</p>
					<p>
						<c:choose>
						<c:when test="${list.cfileSize/4 > 1000*1024 }">
							<fmt:formatNumber value="${list.cfileSize/1024/1024 }" pattern="###.##"/>MB
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${list.cfileSize/1024 }" pattern="###.##"/>KB
						</c:otherwise>
						</c:choose>
					</p>
					<p><fmt:formatDate value="${list.cdate }" pattern="yyyy-MM-dd HH:mm"/></p>
					<!-- 데이터 마지막일때 카운트 -->
					<c:if test="${index.last }">
						<c:set var="lastCnt" value="${index.index}"/>
					</c:if>
				</div>
			</c:forEach>
		</div>
		<div class="scrollLocation">
			
		</div>
	</div>
</div>

<div id="fileUpload" class="dragAndDropDiv">
	<span>업로드할 파일을 이곳에 드래그 & 드롭 해주세요</span>
</div>
<div class="warning"><p><span>
※ 업로드가 완료되지 않은 상태에서 페이지를 이동할 경우 업로드가 되지 않거나 파일이 손상될 수 있습니다.<br><br>
※ 폴더는 업로드가 불가능합니다
</span></p></div>

<script type="text/javascript">
var uid = '${userDTO.uid}';
var lastCnt = ${lastCnt};
var checkStatus = $('#checkStatus').val();
var listStatus = $('.listMyCloud').attr("id");
var inputKeyword = "";
function inputedKeyword(){
	inputKeyword = $('#searchKey').val();
}
console.log("checkStatus : "+checkStatus);
console.log("listStatus : "+listStatus);
//새로고침시 스크롤바 맨 위로
window.onload = function(){
	setTimeout(function(){
		scrollTo(0,0);
	}, 100);
}
//업로드 상태바 숨김
function timeHide(){
	document.getElementById("statusBody").style.display = "none";
	self.setTimeout("location.reload()", 300);
}
//date 포맷
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
	//다운 스크롤
	if(currentScrollNow - lastScrollTop > 0){
		//이전 스크롤 좌표 = 현재 스크롤 좌표
		lastScrollTop = currentScrollNow;
		if($(window).scrollTop() >= ($(document).height() - $(window).height())){
			//ajax로 서버에 데이터 요청
			console.log("스크롤페이징 lastCnt : "+lastCnt);
			console.log("검색어 : "+inputKeyword);
			$.ajax({
				type : 'post',
				url : '/cloud/nextList',
				data : ({	//서버로 보낼 데이터
					cid : lastCnt,
					cuid : uid,
					keyword : inputKeyword
				}),
				//ajax가 성공했을때 실행될 function
				//이때의 data는 되돌려받은 json data임
				success : function(data){
					var str = "";
					console.log(data);
					//받아온 데이터가 null이거나 ""이 아닌경우 핸들링
						if(data != "" && data != null){
							var dataLength = data.length;
							console.log("data.length : "+data.length);
							//data가 list이므로 each를 사용
							$(data).each(
								function(){
									console.log(this);
									var cdate = date_to_str(new Date(this.cdate));	//date_to_str 날짜 포맷 변경
									var cfileSize = this.cfileSize;
									var coriginName = this.coriginName;
									console.log(cfileSize);
									if(cfileSize/4 > 1000*1024){
										cfileSize = (cfileSize/(1024*1024)).toFixed(2)+'MB';
									}else{
										cfileSize = (cfileSize/1024).toFixed(2)+'KB';
									}
									if(coriginName.length > 50){
										coriginName = coriginName.substring(0, 49)+"...";
									}
									if(coriginName == null || coriginName == ""){
										coriginName = "　";
									}
									lastCnt = lastCnt + 1;
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
									str +=	extImg
										+	"<div class='myFiles'>"
										+		"<p class='title'><a href='/resources/upload/"+this.cfileName+"' download>"+coriginName+"</a></p>"
										+		"<p class='scrolling'>"+this.cid+"</p>"
										+		"<p>"+cfileSize+"</p>"
										+		"<p>"+cdate+"</p>"
										+	"</div>";
								}//function END
							);//each END
							//str을 뿌림
							console.log("lastCnt : "+lastCnt);
							$(".scrollLocation").append(str);
						}//if data != '' END
						else{
							swal({
								title: "경고",
								text: "더 불러올 데이터가 없습니다.",
								icon: "warning"
							});
						}//else END
					},//Success function END
					error : function(request,error){
						console.log("message:"+request.responseText);
					}
				}
			);//ajax END
		}//if END
	}//DOM핸들링
});
//검색
function checkSearch(){
	lastScrollTop = 0;
	var inputed = inputKeyword;
	console.log(inputed);
	$.ajax({
		data:{
			keyword : inputed,
			cuid : uid
		},
		url : "/cloud/searchMyList",
		success : function(data){
			var str = "";
			console.log("data : "+data);
			if(data != null && data != ""){
				if(inputed != null && inputed != ""){
					console.log("검색 내용이 있을경우");
					lastCnt = 0;
					$("#defaultList").css("display","none");	//초기 리스트 숨김
					$(".scrollLocation").empty();		//기존 검색리스트 제거
					$(data).each(function(){
						console.log("lastCnt : "+lastCnt);
						lastCnt = lastCnt + 1;
						var cdate = date_to_str(new Date(this.cdate));	//date_to_str 날짜 포맷 변경
						var cfileSize = this.cfileSize;
						var coriginName = this.coriginName;
						console.log(cfileSize);
						if(cfileSize/4 > 1000*1024){
							cfileSize = (cfileSize/(1024*1024)).toFixed(2)+'MB';
						}else{
							cfileSize = (cfileSize/1024).toFixed(2)+'KB';
						}
						if(coriginName.length > 50){
							coriginName = coriginName.substring(0, 49)+"...";
						}
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
					str +=	extImg
						+	"<div class='myFiles'>"
						+		"<p class='title'><a href='/resources/upload/"+this.cfileName+"' download>"+coriginName+"</a></p>"
						+		"<p class='scrolling'>"+this.cid+"</p>"
						+		"<p>"+cfileSize+"</p>"
						+		"<p>"+cdate+"</p>"
						+	"</div>";
					});//each END
					$(".scrollLocation").append(str);
				}//if inputed END
			}//if data END
			else{
				if(inputed == null || inputed == ""){
					console.log("검색 내용이 없을경우");
					$("#defaultList").css("display","block");	//숨겼던거 다시 불러옴
					$(".scrollLocation").empty();	//검색했던 내용 제거
					lastCnt = ${lastCnt};
				}else{
					$("#defaultList").css("display","none");	//초기 리스트 숨김
					$(".scrollLocation").empty();
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
//파일 업로드관련 https://huskdoll.tistory.com/294
$(document).ready(function() {
	var objDragAndDrop = $(".dragAndDropDiv");

	$(document).on("dragenter", ".dragAndDropDiv",
		function(e) {
			e.stopPropagation();
			e.preventDefault();
			$(this).css('border', '2px solid #0B85A1');
		}
	);
	$(document).on("dragover", ".dragAndDropDiv",
		function(e) {
			e.stopPropagation();
			e.preventDefault();
		}
	);
	$(document).on("drop", ".dragAndDropDiv", function(e) {

		$(this).css('border', '2px dotted #0B85A1');
		e.preventDefault();
		var files = e.originalEvent.dataTransfer.files;

		handleFileUpload(files, objDragAndDrop);
	});

	$(document).on('dragenter', function(e) {
		e.stopPropagation();
		e.preventDefault();
	});
	$(document).on('dragover', function(e) {
		e.stopPropagation();
		e.preventDefault();
		objDragAndDrop.css('border', '2px dotted #0B85A1');
	});
	$(document).on('drop', function(e) {
		e.stopPropagation();
		e.preventDefault();
	});

	function handleFileUpload(files, obj) {
		for (var i = 0; i < files.length; i++) {
			var fd = new FormData();
			fd.append('file', files[i]);

			var status = new createStatusbar(obj); //Using this we can set progress.
			status.setFileNameSize(files[i].name, files[i].size);
			sendFileToServer(fd, status);
		}
	}

	var rowCount = 0;
	function createStatusbar(obj) {

		rowCount++;
		var row = "odd";
		if (rowCount % 2 == 0)
			row = "even";
		this.statusbar = $("<div id='statusBody'><div class='statusbar "+row+"'></div><div>");
		this.filename = $("<div class='filename'></div>")
			.appendTo(this.statusbar);
		this.size = $("<div class='filesize'></div>")
			.appendTo(this.statusbar);
		this.progressBar = $("<div class='progressBar'><div></div></div>")
			.appendTo(this.statusbar);
		this.abort = $("<div class='abort'>중지</div>")
			.appendTo(this.statusbar);

		obj.after(this.statusbar);

		this.setFileNameSize = function(name, size) {
			var sizeStr = "";
			var sizeKB = size / 1024;
			if (parseInt(sizeKB) > 1024) {
				var sizeMB = sizeKB / 1024;
				sizeStr = sizeMB.toFixed(2) + " MB";
			} else {
				sizeStr = sizeKB.toFixed(2) + " KB";
			}

			this.filename.html(name);
			this.size.html(sizeStr);
		}

		this.setProgress = function(progress) {
			var progressBarWidth = progress * this.progressBar.width() / 100;
			this.progressBar.find('div')
				.animate({width : progressBarWidth}, 10)
				.html(progress + "% ");
			if (parseInt(progress) >= 100) {
				this.abort.hide();
			}
		}

		this.setAbort = function(jqxhr) {
			var sb = this.statusbar;
			this.abort.click(function() {
				jqxhr.abort();
				sb.hide();
			});
		}
	}

	function sendFileToServer(formData, status) {
		var uploadURL = "/cloud/myCloud"; //Upload URL
		var extraData = {}; //Extra Data.
		var reloadCk = $('#checkUpload').attr('value');
		console.log("reloadCk : "+reloadCk);
		var jqXHR = $
			.ajax({
				xhr : function() {
					var xhrobj = $.ajaxSettings.xhr();
					if (xhrobj.upload) {
						xhrobj.upload.addEventListener('progress', function(event) {
							var percent = 0;
							var position = event.loaded || event.position;
							var total = event.total;
							
							if (event.lengthComputable) {
								percent = Math.ceil(position / total * 100);
							}
							//Set progress
							status.setProgress(percent);
						}, false);
					}
					return xhrobj;
				},
				url : uploadURL,
				type : "POST",
				contentType : false,
				processData : false,
				cache : false,
				data : formData,
				success : function(data) {
					console.log("uploadURL : "+uploadURL);
					status.setProgress(100);
					setTimeout("timeHide()", 500);
					//$(".statusbar "+row+"").append("File upload Done<br>");
				},
				error : function(request,error){
					console.log("message:"+request.responseText);
				}
			});
		status.setAbort(jqXHR);
		console.log(jqXHR);
	}
});

</script>
</body>
</html>