<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">

function getAddr(pageNo) {

	if ($("#keyword").val() == "") {
	    alert("검색어를 입력해주세요.");
	    return;
	}
	
	$("#currentPage").val(pageNo);
	
	// AJAX 주소 검색 요청
	$.ajax({
	    url : "https://www.juso.go.kr/addrlink/addrLinkApiJsonp.do",
		    type : "post",
		    data : $("#jusoSearchForm").serialize(), // 요청 변수 설정	    
		    dataType : "jsonp",
		    crossDomain : true,
	    success : function(jsonStr) { // jsonStr : 주소 검색 결과 JSON 데이터
	
			var errCode = jsonStr.results.common.errorCode;
			var errDesc = jsonStr.results.common.errorMessage;
	
			if (errCode != "0") {
			    log.console(errCode + "=" + errDesc);
			}
	
			else {
			    if (jsonStr != null) {
				makeListJson(jsonStr); // 결과 JSON 데이터 파싱 및 출력
				var pageStr = Paging(jsonStr.results.common.totalCount,
					"10", "10", $("#currentPage").val(), "juso");
				$("#juso_pager").empty().html(pageStr);
			    }
			}
	    },
	    error : function(xhr, status, error) {
			debugger;
			alert("주소를 가져오는데 실패하였습니다."); // AJAX 호출 에러
	    }
	});
}

// 주소 페이지 이동
function goPaging_juso(pageNo) {
	getAddr(pageNo);
}

// 목록 생성
function makeListJson(jsonStr) {

	var htmlStr = "";
	
	$("#juso_list > tbody >  tr").remove();
	
	var cnt = 0;
	var pagecount = jsonStr.results.common.countPerPage;
	var curpage = jsonStr.results.common.currentPage;
	var totCnt = jsonStr.results.common.totalCount;
	
	$("#juso_total").html(totCnt);
	
	$(jsonStr.results.juso).each(
		function() {
		    htmlStr += "<tr style='cursor:pointer' onClick=\"setAddr('"
			    + this.roadAddr + "','" + this.roadAddr + "','"
			    + this.zipNo + "','" + this.admCd.substring(0, 4)
			    + "');jusoPopupClose();\">";
		    htmlStr += "<td class='first'>" + (totCnt - ((pagecount * (curpage - 1)) + cnt++)) + "</td>";
		    htmlStr += "<td style='text-align:left'>" + this.roadAddr + "<br/>" + this.jibunAddr + "</td>";
		    htmlStr += "<td style='text-align:center'>" + this.rn + "</td>";
		    htmlStr += "<td class='last'>" + this.zipNo + "</td>";
		    htmlStr += "</tr>";
		});
	
	$("#juso_list").append(htmlStr);
}

// 목록 페이징
function Paging(totalCnt, dataSize, pageSize, pageNo, token) {

	totalCnt = parseInt(totalCnt); // 전체레코드수
	dataSize = parseInt(dataSize); // 페이지당 보여줄 데이타수
	pageSize = parseInt(pageSize); // 페이지 그룹 범위       1 2 3 5 6 7 8 9 10
	pageNo = parseInt(pageNo); // 현재페이지
	
	var html = new Array();
	if (totalCnt == 0) {
	    return "";
	}
	
	// 페이지 카운트
	var pageCnt = totalCnt % dataSize;
	if (pageCnt == 0) {
	    pageCnt = parseInt(totalCnt / dataSize);
	} else {
	    pageCnt = parseInt(totalCnt / dataSize) + 1;
	}
	
	var pRCnt = parseInt(pageNo / pageSize);
	if (pageNo % pageSize == 0) {
	    pRCnt = parseInt(pageNo / pageSize) - 1;
	}
	
	//이전 화살표
	if (pageNo > pageSize) {
	    
	    var s2;
	    
	    if (pageNo % pageSize == 0) {
			s2 = pageNo - pageSize;
	    } else {
			s2 = pageNo - pageNo % pageSize;
	    }
	    
	    html.push('<a href=javascript:goPaging_' + token + '("');
	    html.push(s2);
	    html.push('"); title="전 페이지로 이동">');
	    html.push('<img src="/images/admin/common/btn_paging_prev.png" alt="전 페이지로 이동" />');
	    html.push("</a>");
	    
	} else {
	    
	    html.push('<a href="#">\n');
	    html.push('<img src="/images/admin/common/btn_paging_prev.png" alt="전 페이지로 이동" />');
	    html.push('</a>');
	    
	}
	
	//paging Bar
	for (var index = pRCnt * pageSize + 1; index < (pRCnt + 1) * pageSize + 1; index++) {
	    
	    if (index == pageNo) {
			html.push('<strong>');
			html.push(index);
			html.push('</strong>');
	    } else {
			html.push('<a href=javascript:goPaging_' + token + '("');
			html.push(index);
			html.push('");>');
			html.push(index);
			html.push('</a>');
	    }
	    
	    if (index == pageCnt) {
			break;
	    } else {
			html.push('|');
	    }
	}
	
	//다음 화살표
	if (pageCnt > (pRCnt + 1) * pageSize) {
	    
	    html.push('<a href=javascript:goPaging_' + token + '("');
	    html.push((pRCnt + 1) * pageSize + 1);
	    html.push('"); title="다음 페이지로 이동">');
	    html.push('<img src="/images/admin/common/btn_paging_next.png" alt="다음 페이지로 이동" />');
	    html.push('</a>');
	    
	} else {
	    
	    html.push('<a href="#">');
	    html.push('<img src="/images/admin/common/btn_paging_next.png" alt="다음 페이지로 이동" />');
	    html.push('</a>');
	}
	
	return html.join("");
}

function enterKey() {
	if (window.event.keyCode == 13) {
	    getAddr(1);
	}
}

function addrReset() {
	$("#keyword").val("");
}

function jusoPopupShow() {
	$('#modal-juso-write').modal('show');
}

function jusoPopupClose() {
	$('#modal-juso-write').modal('hide');
}
    
</script>

<div class="modal fade" id="modal-juso-write">

	<div class="modal-dialog modal-size-small">
	
		<!-- header -->
		<div id="pop_header">
			<header>
				<h1 class="pop_title">주소검색</h1>
				<a href="javascript:jusoPopupClose()" class="pop_close" title="페이지 닫기"> <span>닫기</span>
				</a>
			</header>
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="pop_container">
		
			<article>
			
				<div class="pop_content_area">
				
					<div id="juso_pop_content" style="margin: 10px">
					
						<form name="jusoSearchForm" id="jusoSearchForm" method="post" onSubmit="return false;">
						
							<!-- 요청 변수 설정 (현재 페이지) -->
							<input type="hidden" id="currentPage" name="currentPage" value="1" />
							
							<!-- 요청 변수 설정 (페이지당 출력 개수) -->
							<input type="hidden" id="countPerPage" name="countPerPage" value="10" />
							
							<!-- 요청 변수 설정 (검색결과형식 설정, json) -->
							<input type="hidden" name="resultType" value="json" />
							
							<!-- 요청 변수 설정 (승인키) -->
							<input type="hidden" name="confmKey" value="U01TX0FVVEgyMDE3MDIyNTEyMzk1NTE5Mjcz" />							

							<!-- search_area -->
							<div class="search_area">
							
								<table class="search_box">
									<caption>주소검색 화면</caption>
									<colgroup>
										<col style="width: 90%;" />
									</colgroup>
									<tbody>
										<tr>
											<td><input id="keyword" name="keyword" type="input" value="" class="in_w100" placeholder="검색어를 입력하세요(반포대로 58, 독립기념관, 삼성동 25)" onkeyup="enterKey()" /></br></td>
										</tr>
									</tbody>
								</table>
								
								<div class="search_area_btnarea">
									<a href="javascript:getAddr(1)" class="btn sch" title="조회하기"> <span>조회</span>
									</a> <a href="javascript:addrReset();" class="btn clear" title="검색 초기화"> <span>초기화</span>
									</a>
								</div>
							</div>
							<!--// search_area -->
							
							<div class="table_search_area">
								<div class="float_left">
									<span>도로명주소 검색 결과 (<strong id="juso_total" class="color_pointo">0</strong>건)
									</span>
								</div>
							</div>
							
							<!-- table 2dan list -->
							<div class="table_area">
								<table id="juso_list" class="list">
									<caption>리스트 화면</caption>
									<colgroup>
										<col style="width: 5%;" />
										<col style="width:;" />
										<col style="width: 15%;" />
										<col style="width: 10%;" />
									</colgroup>
									<thead>
										<tr>
											<th class="first" scope="col">No</th>
											<th scope="col">도로명주소</th>
											<th scope="col">행정동</th>
											<th class="last" scope="col">우편번호</th>
										</tr>
									</thead>
									<tbody>
										<td style="text-align: center" colspan="4">검색된 주소가 없습니다</td>
									</tbody>
								</table>
							</div>
							<!--// table 2dan list -->
							
							<!-- paging_area -->
							<div id="juso_pager" class="paging_area"></div>
							<!-- //paging_area -->

						</form>

					</div>
					
				</div>
				
			</article>
			
		</div>
		<!-- //container -->
		
	</div>
</div>