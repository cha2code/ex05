<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.umd.js">
</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.css"/>

<script>
$(document).ready(function() {

	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;		
		document.forms.removeForm.submit();
	});	
	
	Fancybox.bind('[data-fancybox="gallery"]', {
		
	});
	
	$('.sm-images > img').mouseenter(function(e) {
		let src = $(this).attr('src');
		$('.image-pannel > img').attr('src', src);
	});

}); 

</script>

<br>

<h1 class="page-header"><i class="far fa-file-alt"></i> ${travel.title}</h1>

<br>
	
<div class="d-flex justify-content-between">

	<div>
		<i class="fa-solid fa-location-dot"></i> ${travel.region}
	</div>
	
	<div>
		<i class="fa-solid fa-phone"></i> ${travel.phone}
	</div>
	
	<div>
		<i class="fa-regular fa-address-book"></i> ${travel.address}
	</div>
	
</div>
	
<hr>

<div class="clearfix">
	<div class="image-panel float-left mr-3 mb-5">
		<img src="${travel.image}">
		<div class="sm-images mt-1 ml-1 d-flex">
			<c:forEach var="image" items="${travel.images}">
				<img src="${image}">
			</c:forEach>                                
		</div>
	</div>
	${travel.description}
</div>

<br>

<%-- <!-- data-XXXX="OOOO" : 임의로 결정 -->
<div class="thumb-images my-5 d-flex">
	<c:forEach var="image" items="${travel.images}">
		<a href="${image}" data-fancybox="gallery">
			<img src="${image}">
		</a>
	</c:forEach>
</div> --%>

<div id="map" style="width:100%;height:300px;background:gray"></div>

<div class="mt-4">
	<a href="${cri.getLink('list') }" class="btn btn-primary list">
		<i class="fas fa-list"></i> 목록 </a>
	
	<sec:authorize access="hasRole('ROLE_MANAGER')">
		<a href="${cri.getLink('modify')}&no=${travel.no}" class="btn btn-primary modify">
			<i class="far fa-edit"></i> 수정 </a>
		
		<a href="#" class="btn btn-danger remove">
			<i class="fas fa-trash-alt"></i> 삭제 </a>
	</sec:authorize>
</div>

<form action="remove" method="post" name="removeForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="no" value="${travel.no}"/>
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
	<input type="hidden" name="type" value="${cri.type}"/>
	<input type="hidden" name="keyword" value="${cri.keyword}"/>
</form>

<!-- javascript로 dom 처리 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=549b4a588c392d67d9937e3a07032a20&libraries=services">
</script>
<script>

	let geocoder = new kakao.maps.services.Geocoder();
	let address = '${travel.address}';
	
	// 비동기 : callback 등록
	geocoder.addressSearch(address, function(result, status){ // result: 배열
		
	// 주소를 찾았을 때만 출력
	if(status === kakao.maps.services.Status.OK){
			
		// 배열의 첫번째 위치로 이동
		// result[0].y, result[0].x : 좌표로 찍힘
		let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		// 'map' : 해당 div태그에 대한 참조를 리턴
		let mapContainer = document.getElementById('map');
			
		let mapOption = {
		  center: coords, // 중심 좌표
		  level: 3 // 지도의 확대 레벨
		};
			
		let map = new kakao.maps.Map(mapContainer, mapOption);
			
		let marker = new kakao.maps.Marker({
			map: map,
			position: coords
		});
			
		// 이미 중심이 잡혀 있기 때문에 또 이동할 필요 없어서 주석 처리
		// 지도의 중심 값을 결과 값으로 받은 위치로 이동시킴
		//map.setCenter(coords);
		}
	
	else {
		
		alert("잘못된 주소입니다.");
	}
	
	});


  
  // 1. map을 만들어 고정된 좌표로 감 2. 빠르게 상단의 비동기 파트 실행
  
 /*  // 마커가 표시될 위치
  var markerPosition = new kakao.maps.LatLng(66.551839, 25.856935);
  
  // 마커 생성
  var marker = new kakao.maps.Marker({
	  position: markerPosition
  });
  
  // 마커가 지도 위에 표시되도록 설정
  marker.setMap(map); */

</script>

<%@include file="../layouts/footer.jsp"%>