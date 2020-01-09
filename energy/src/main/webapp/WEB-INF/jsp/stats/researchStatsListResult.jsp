<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">
	

</script>

			<table class="statistics_list fixed">
				<caption>리스트 화면</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 180px;" />
					<col style="width: 180px;" />
					<col style="width: 180px;" />
					<c:forEach var="item" items="${stats_title}" >
						<c:forEach var="i" items="${item.name}" varStatus="status">
							<col style="width: 70px;" />
						</c:forEach>
					</c:forEach>
						<c:if test="${empty stats_title}">
								<col style="width: *;" />
						</c:if>
				</colgroup>
				<thead>
					<tr>
						<th scope="col" rowspan="2" class="first">업종</th>
						<th scope="col" rowspan="2">대분류</th>
						<th scope="col" rowspan="2">중분류</th>
						<th scope="col" rowspan="2">소분류</th>
						<c:forEach var="item" items="${stats_title}" >
							<c:forEach var="i" items="${item.name}" varStatus="status">
								<c:if test="${status.last}" >
									<th scope="col" colspan="${status.count}" class="last">${params.stats_m_nm}</th> 
								</c:if>
							</c:forEach>
						</c:forEach>
						<c:if test="${empty stats_title}">
								<th scope="col" colspan="1" class="last">통계표</th> 
						</c:if>
						
					</tr>
					<tr>
						<c:forEach var="item" items="${stats_title}" >
							<c:forEach var="i" items="${item.name}" varStatus="status">
								<th scope="col" <c:if test="${status.last}" > class="last" </c:if> >${i}</th>
							</c:forEach>
						</c:forEach>
					</tr>
					
				</thead>
				<tbody>
					<c:forEach var="item" items="${stats_list}" varStatus="status">
					<tr>
						<td class="alignl bg" <c:if test="${status.first}" > class="first"</c:if> >${item.inds_tp_nm}</td>
						<td class="alignl bg">${item.wbiz_tp_l_nm}</td>
						<td class="alignl bg">${item.wbiz_tp_m_nm}</td>
						<td class="alignl bg">${item.wbiz_tp_s_nm}</td>
						<!-- group_concat으로 넘어온거 처리 -->
							<c:forEach var="i" items="${item.point}" varStatus="status">
								<td <c:if test="${status.last}" > class="last" </c:if> >${i}</td>
							</c:forEach>
					</tr>
					</c:forEach>
				</tbody>
			</table>
