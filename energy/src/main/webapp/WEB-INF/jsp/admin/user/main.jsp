<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- <script src="/assets/canvas/canvasjs.min.js"></script>  -->

<style>
	table th { text-align:center; bold;}
	table td { text-align:center; }
</style>

<!-- content -->
<div id="content">

	<div class="site_area">
	
		<ul class="site_list">
		
		    <c:set var="preUpMenuId" value=""/>
		    <c:set var="menuIdx" value="0"/>
		    <c:set var="menuSubCnt" value="0"/>
		    <c:set var="menuSub2Cnt" value="0"/>
		    <c:set var="preLvl" value="2"/>
		    
		    <c:choose>
		    	<c:when test="${ sitemapList[0].sub_cnt < 1 }">
		    	<c:set var="listSize" value="${ fn:length(sitemapList) }" />
		    	<c:forEach var="row" items="${sitemapList}" varStatus="status">
			
			<c:if test="${preUpMenuId != sitemapList[listSize - status.count].up_menu_id}">
			
				<c:if test="${menuSub2Cnt > 0}">
								</ul>
							</li>
				</c:if> 	
					 
		        <c:if test="${menuSubCnt > 0}">
						</ul>
					</div>	
		        </c:if>
		        
		        <c:set var="menuSubCnt" value="0"/>
		        
		        <c:if test="${menuIdx > 0}">
                   </li>
		        </c:if>
		        			        
				<li>
					<div class="site_title">
						<strong>${sitemapList[listSize - status.count].menu_nm}</strong>
					</div>
					
					<c:if test="${sitemapList[listSize - status.count].sub_cnt > 0}">
					
					<div class="site_link_area">
						<ul>
					</c:if>
					
					<c:set var="preLvl" value="2"/>
					<c:set var="menuSubCnt" value="${sitemapList[listSize - status.count].sub_cnt}"/>							
			</c:if>
			
			
                        <c:if test="${sitemapList[listSize - status.count].lvl == 2}">
                        
                                <c:if test="${preLvl != sitemapList[listSize - status.count].lvl}">
						</ul>
                                </c:if> 
                                
					<li>
						<a href="javascript:goPage('${sitemapList[listSize - status.count].menu_id}','')" title="${sitemapList[listSize - status.count].menu_nm} 페이지로 이동">
							<span>${sitemapList[listSize - status.count].menu_nm}</span>
						</a>
						
					<c:if test="${sitemapList[listSize - status.count].sub_cnt > 0}">	
						<ul class="sub_menu">
					</c:if>
					
					<c:if test="${sitemapList[listSize - status.count].sub_cnt < 1}">	
					</li>									
					</c:if>
					
					<c:set var="menuSub2Cnt" value="${sitemapList[listSize - status.count].sub_cnt}"/>
			        <c:set var="preLvl" value="${sitemapList[listSize - status.count].lvl}"/>		
			</c:if>		
			
			
                        <c:if test="${sitemapList[listSize - status.count].lvl == 3}">
                        
						<li>
							<a href="javascript:goPage('${sitemapList[listSize - status.count].menu_id}','')" title="${sitemapList[listSize - status.count].menu_nm} 페이지로 이동">
								<span>${sitemapList[listSize - status.count].menu_nm}</span>
							</a>
						</li>			
											
				<c:set var="preLvl" value="${sitemapList[listSize - status.count].lvl}"/>
				
			</c:if>
			
			<c:set var="menuIdx" value="${menuIdx+1 }"/>
			<c:set var="preUpMenuId" value="${sitemapList[listSize - status.count].up_menu_id}"/>
			
                    	</c:forEach>
		    	
		    	
		    	</c:when>
		    	<c:otherwise>
		    	<c:forEach var="row" items="${sitemapList}" varStatus="status">
			
			<c:if test="${preUpMenuId != row.up_menu_id}">
			
				<c:if test="${menuSub2Cnt > 0}">
								</ul>
							</li>
				</c:if> 	
					 
		        <c:if test="${menuSubCnt > 0}">
						</ul>
					</div>	
		        </c:if>
		        
		        <c:set var="menuSubCnt" value="0"/>
		        
		        <c:if test="${menuIdx > 0}">
                   </li>
		        </c:if>
		        			        
				<li>
					<div class="site_title">
						<strong>${row.menu_nm}</strong>
					</div>
					
					<c:if test="${row.sub_cnt > 0}">
					
					<div class="site_link_area">
						<ul>
					</c:if>
					
					<c:set var="preLvl" value="2"/>
					<c:set var="menuSubCnt" value="${row.sub_cnt}"/>							
			</c:if>
			
			
                        <c:if test="${row.lvl == 2}">
                        
                                <c:if test="${preLvl != row.lvl}">
						</ul>
                                </c:if> 
                                
					<li>
					<c:if test="${row.sub_cnt < 1}">
						<a href="javascript:goPage('${row.menu_id}','')" title="${row.menu_nm} 페이지로 이동">
							<span>${row.menu_nm}</span>
						</a>
					</c:if>	
					<c:if test="${row.sub_cnt > 0}">	
					    <span>${row.menu_nm}</span>
					    
						<ul class="sub_menu">
					</c:if>
					
					<c:if test="${row.sub_cnt < 1}">	
					</li>									
					</c:if>
					
					<c:set var="menuSub2Cnt" value="${row.sub_cnt}"/>
			        <c:set var="preLvl" value="${row.lvl}"/>		
			</c:if>		
			
			
                        <c:if test="${row.lvl == 3}">
                        <c:if test="${row.sub_cnt < 1}">
						<li>
							<a href="javascript:goPage('${row.menu_id}','')" title="${row.menu_nm} 페이지로 이동">
								<span>${row.menu_nm}</span>
							</a>
						</c:if>			
						
						<c:if test="${row.sub_cnt > 0}">
						   <span>${row.menu_nm}</span>
						</c:if>
						</li>
											
				<c:set var="preLvl" value="${row.lvl}"/>
				
			</c:if>
			
			<c:set var="menuIdx" value="${menuIdx+1 }"/>
			<c:set var="preUpMenuId" value="${row.up_menu_id}"/>
			
                    	</c:forEach>
		    	</c:otherwise>
		    </c:choose>
					</ul>
				</div>								
			</li>		
		</ul>
	</div>					
</div>
<!--// content -->
				