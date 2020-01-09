<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>


				</div>
				<!--// 메인영역 -->
				
			</div>
			
		</article>	
		
		</div>
		<!-- //container -->
		
		<!-- footer --> 
		<div id="footer">
			<footer>
				<div class="footer_select_area">
					<ul>
						<li>
							<a href="javascript:showOrganList('1')" title="외형 및 소속기관">
								<span>외형 및 소속기관</span>
							</a>
							<div class="footer_sub_menu" id="footer_sub_menu_1">
								<ul id="main_footer_sub_menu_1"></ul>
							</div>
						</li>
						<li>
							<a href="javascript:showOrganList('2')" title="관련기관">
								<span>관련기관</span>
							</a>
							<div class="footer_sub_menu" id="footer_sub_menu_2">
								<ul id="main_footer_sub_menu_2"></ul>
							</div>
						</li>
						<li>
							<a href="javascript:showOrganList('3')" title="다른 행정기관">
								<span>다른 행정기관</span>
							</a>
							<div class="footer_sub_menu" id="footer_sub_menu_3">
								<ul id="main_footer_sub_menu_3"></ul>
							</div>
						</li>
						<li>
							<a href="javascript:showOrganList('4')" title="지방자치단체">
								<span>지방자치단체</span>
							</a>
							<div class="footer_sub_menu" id="footer_sub_menu_4">
								<ul id="main_footer_sub_menu_4"></ul>
							</div>
						</li>
					</ul>
				</div>
				
				<div class="footer_area">
				
					<div class="footer_logo_area">
						<img src="/contents/logo/${Logo.front_bottom_file_nm}" alt="환경부 물시장종합정보센터" style="cursor:pointer " />
					</div>
					
					<!-- footer_right --> 
					<div class="footer_right">
					
						<div class="footer_list">							
							<ul>
								<li>
									<a href="javascript:goPage('d76a91d0c7b84491b604030cb037b007', '', '')" title="이용약관 페이지로 이동">
										<span>이용약관</span>
									</a>
								</li>
								<li class="privacy_o">
									<a href="javascript:goPage('567f5b95aa354f21bfcc1694e490c145', '', '')" title="개인정보보호정책 페이지로 이동">
										<span>개인정보보호정책</span>
									</a>
								</li>
							</ul>
						</div>
						
						<div class="footer_content">								
								<ul class="footer_addr_list">
									<li>
										<address>
											<%=(String)ProjectConfigUtil.getProperty("project.site.address") %>
										</address>
									</li>
									<li>
										<span><%=(String)ProjectConfigUtil.getProperty("project.site.contact") %></span>
									</li>
								</ul>
								<p class="footer_txt">
								본 홈페이지의 내용은 저작권법에 의해 보호를 받는 저작물로서, 이에 대한 무단 복제 및 배포를 원칙적으로 금하며 홈페이지에 게재된 이메일 주소의 수집을 거부합니다.<br />
								이를 위반 시 관련법에 의해 처벌됨을 유념하시기 바랍니다.</p>
								<p class="footer_copyright">© <%=(String)ProjectConfigUtil.getProperty("project.site.copyright") %></p>
							</div>
						</div>
						
					</div>
					<!--// footer_right -->
						
				</div>
			</footer>
		</div>
		<!-- //footer -->
		
	</div>
	<!-- //wrap -->
	
	