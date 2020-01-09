<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script type="text/javascript">
	<!--
	$(document).ready(function(){
		$( ".layer_close" ).click(function(){
			$( ".layer_sitemap" ).hide();
		});
	});
	//-->
</script>
<div>
	<span><img src="/images/common/layer_close_bt.png" class="layer_close" alt="레이어 팝업 사이트맵 닫기"></span>
	<div class="contents_sitemap">
		<div class="marginb10 font30p">사이트맵</div>

		<c:set var="preUpMenuId" value=""/>
		<c:set var="menuIdx" value="0"/>
		<c:set var="menuSubCnt" value="0"/>
		<c:set var="menuSub2Cnt" value="0"/>
		<c:set var="preLvl" value="2"/>
		<%--<c:set var="url" value=""/>--%>

		<c:forEach var="row" items="${sitemapList}" varStatus="status">

		<c:if test="${preUpMenuId != row.up_menu_id}">
		<c:if test="${menuSub2Cnt > 0}">
			</p>
			</td>
			</tr>
		</c:if>
		<c:if test="${menuSubCnt > 0}">
			</tr>
			</tbody>
			</table>
		</c:if>

		<c:set var="menuSubCnt" value="0"/>

		<c:if test="${menuIdx > 0}">
			</li>
			</ul>
		</c:if>

		<ul>
			<li>
				<%--<a href="/energy/web/WEB-INF/jsp/int/int-01.html" title="재단소개" target="_self">${row.menu_nm}</a>--%>
					<c:if test="${row.menu_type == 'F'}">
						<a href="javascript:goTopMenu('${row.ref_menu_url}','${row.menu_id}','${row.menu_nm}','${row.ref_menu}','1','///');" title="${row.menu_nm}">${row.menu_nm}</a>
					</c:if>
					<c:if test="${row.menu_type == 'B'}">

						<a href="javascript:goTopMenu('/web/board/boardContentsListPage.do?board_id=${row.board}','${row.menu_id}','${row.menu_nm}','','','///');" title="${row.menu_nm}" >${row.menu_nm}</a>
					</c:if>
					<c:if test="${row.menu_type == 'C'}">
						<a href="javascript:goTopMenu('/web/intropage/intropageShow.do?page_id=${row.contents}','${row.menu_id}','${row.menu_nm}','1','///');" title="'+menu.menu_nm+'" >'+menu.menu_nm+'</a>
					</c:if>
			</li>
			<c:if test="${row.sub_cnt > 0}">
			<li>

					<table>
						<caption>사이트맵</caption>
						<colgroup>
							<col>
							<col>
						</colgroup>
						<tbody>
					</c:if>
						<c:set var="preLvl" value="2"/>
						<c:set var="menuSubCnt" value="${row.sub_cnt}"/>
					</c:if>
					<!-- 메뉴 레벨 2 일 경우 -->
					<c:if test="${row.lvl == 2}">
					<c:if test="${preLvl == 3}">
						<%--</tbody>--%>
					<%--</table>--%>
			<%--</li>--%>
		<%--</ul>--%>
		</c:if>
		<tr>
			<th>
				<a href="javascript:goPage('${row.menu_id}','')" title="${row.menu_nm}" target="_self">${row.menu_nm}</a>
			</th>

			<c:if test="${row.sub_cnt < 1}">
			<td></td>
			</c:if>
		<c:set var="menuSub2Cnt" value="${row.sub_cnt}"/>

		</c:if>
		<c:if test="${row.lvl == 3}">
		<c:if test="${preLvl == 2}">
			<td>
				<p>
			</c:if>


				<a href="javascript:goPage('${row.menu_id}','')" title="${row.menu_nm} 페이지로 이동">
					ㆍ${row.menu_nm}
				</a>

			</c:if>

				<c:set var="preLvl" value="${row.lvl}"/>
				<c:set var="menuIdx" value="${menuIdx+1 }"/>
				<c:set var="preUpMenuId" value="${row.up_menu_id}"/>


			</c:forEach>






	</div>
</div>