<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
		<div class="page_title">
			<h2 class="title">업종별 등록 결과</h2>
		</div>

		<div class="table_area">
			<table class="list" id="listIndustry">
				<caption>업종별 등록 결과</caption>
				<colgroup>
					<col style="width: 4%;" />
					<col style="width: 6%;" />
					<col style="width: 6%;" />
					<col style="width: 10%;" />
					<col style="width: 6%;" />
					<col style="width: 10%;" />
					<col style="width: 6%;" />
					<col style="width: 12%;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">기준연도</th>
						<th scope="col">업종코드</th>
						<th scope="col">업종명</th>
						<th scope="col">대분류코드</th>
						<th scope="col">대분류명</th>
						<th scope="col">중분류코드</th>
						<th scope="col">중분류명</th>
						<th scope="col">세분류코드</th>
						<th scope="col">세분류명</th>
						<th scope="col">처리상태</th>
					</tr>
				</thead>
				<tbody>				
					<c:forEach var="excels" items="${industry}">
					<tr>
						<td>${excels.bs_yy}</td>
						<td>${excels.inds_tp_cd}</td>
						<td>${excels.inds_tp_nm}</td>
						<td>${excels.wbiz_tp_l_cd}</td>
						<td>${excels.wbiz_tp_l_nm}</td>
						<td>${excels.wbiz_tp_m_cd}</td>
						<td>${excels.wbiz_tp_m_nm}</td>
						<td>${excels.wbiz_tp_s_cd}</td>
						<td>${excels.wbiz_tp_s_nm}</td>
						<td>${excels.status}</td>
					</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>	
		<!-- main_title -->
		<div class="page_title">
			<h2 class="title">규모별 등록 결과</h2>
		</div>
		<!--// main_title -->
		<!--// table_area -->		
		<div class="table_area">
			<table class="list" id="listScale">
				<caption>규모별 등록 결과</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 10%;" />
					<col style="width: 30%;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">기준연도</th>
						<th scope="col">업종규모코드</th>
						<th scope="col">업종규모명</th>
						<th scope="col">처리상태</th>
					</tr>
				</thead>
				<tbody>				
					<c:forEach var="excels" items="${scale}">
					<tr>
						<td>${excels.bs_yy}</td>
						<td>${excels.scale_cd}</td>
						<td>${excels.scale_nm}</td>
						<td>${excels.status}</td>
					</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>	
	<!-- button_area -->
	<div id="addBts" class="button_area">
		<div class="alignc">
			<a href="javascript:excelCancel()" class="btn save" title="목록">
				<span>목록</span>
			</a>
		</div>
	</div>
	<!--// button_area -->
	<!--// table_area -->		
