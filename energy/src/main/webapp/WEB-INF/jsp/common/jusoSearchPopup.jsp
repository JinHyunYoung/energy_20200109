<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

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
					
					var pageStr = Paging(jsonStr.results.common.totalCount,"10", "10", $("#currentPage").val(), "juso");
					
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

function goPaging_juso(pageNo) {
	getAddr(pageNo);
}

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
		    htmlStr += "<tr style='cursor:pointer' onClick=\"setAddr('" + this.roadAddr + "','" + this.roadAddr + "','"+ this.zipNo + "','" + this.admCd.substring(0, 4) + "');jusoPopupClose();\">";
		    htmlStr += "<td class='first'>" + (totCnt - ((pagecount * (curpage - 1)) + cnt++)) + "</td>";
		    htmlStr += "<td class='alignl'><a href=\"javascript:setAddr('" + this.roadAddr  + "','" + this.roadAddr  + "','"  + this.zipNo  + "','"  + this.admCd.substring(0, 4) + "');jusoPopupClose();\">" + this.roadAddr + "<br/>" + this.jibunAddr + "</a></td>";
		    htmlStr += "<td>" + this.rn + "</td>";
		    htmlStr += "<td class='last'>" + this.zipNo + "</td>";
		    htmlStr += "</tr>";
		}
	);
	
	$("#juso_list").append(htmlStr);
}

// 목록 페이징
function Paging(totalCnt, dataSize, pageSize, pageNo, token) {

	totalCnt = parseInt(totalCnt);// 전체레코드수
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
	    html.push('<img src="/images/web/common/btn_paging_prev.png" alt="전 페이지로 이동" />');
	    html.push("</a>");
	    
	} else {
	    
	    html.push('<a href="#">\n');
	    html.push('<img src="/images/web/common/btn_paging_prev.png" alt="전 페이지로 이동" />');
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
	    html.push('<img src="/images/web/common/btn_paging_next.png" alt="다음 페이지로 이동" />');
	    html.push('</a>');
	} else {
	    html.push('<a href="#">');
	    html.push('<img src="/images/web/common/btn_paging_next.png" alt="다음 페이지로 이동" />');
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
	//$('#modal-juso-write').modal('show');
	$('#modal-juso-write').popup('show');
}

function jusoPopupClose() {
	//$('#modal-juso-write').modal('hide');
	$('#modal-juso-write').popup('hide');
}
        
</script>

<div id="modal-juso-write">

	<div class="modal-dialog modal-size-small">
	
		<!-- header -->
		<div id="pop_header" style="height:20px">
			<header>
				<h1 class="pop_title">주소검색</h1>
				<a href="javascript:jusoPopupClose()" class="pop_close" title="페이지 닫기"> 
					<span>닫기</span>
				</a>
			</header>
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="pop_container">
		
			<article>
			
				<div class="pop_content_area">
				
					<div id="pop_content">
					
						<div class="division">					
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
									<dl class="search_box">
										<dt class="title">주소입력</dt>
										<dd class="box">
											<label for="keyword" class="hidden">검색어 입력창</label> 
											<input id="keyword" name="keyword" type="text" value="" class="in_w60" placeholder="검색어를 입력하세요(반포대로)" onkeyup="enterKey()" />
											<div class="search_btn_area">
												<button class="btn sch" title="조회" onclick="getAddr(1)">
													<span>조회</span>
												</button>
												<!-- 
												<button class="btn clear" title="초기화" onclick="addrReset()">
					                        		<span>초기화</span>
					                    		</button> 
					                    		-->
											</div>
										</dd>
									</dl>
								</div>
								<!--// search_area -->
								
								<!-- table_top_area -->	
								<div class="table_top_area">
									<div class="table_top_left">
										<p>검색 결과 (<strong id="juso_total" class="table_count">0</strong>건)</p>
									</div>
								</div>
								<!-- table_top_area -->
								
								<!-- table_area -->
								<div class="table_area">
									<table id="juso_list" class="list">
										<caption>주소검색 목록 화면</caption>
										<colgroup>
											<col style="width: 10%;" />
											<col style="width: *;" />
											<col style="width: 20%;" />
											<col style="width: 15%;" />
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
											<tr>
												<td colspan="4" class="first last">검색된 주소가 없습니다</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!--// table_area -->
								
								<!-- paging_area -->
								<div id="juso_pager" class="paging_area"></div>
								<!-- //paging_area -->
	
							</form>
						</div>

					</div>
					
				</div>
				
			</article>
			
		</div>
		<!-- //container -->
		
	</div>
</div>