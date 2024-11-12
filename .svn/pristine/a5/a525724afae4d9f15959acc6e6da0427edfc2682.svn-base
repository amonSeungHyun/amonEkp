<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%--<jsp:include page="/include/includeEditor.jsp" flush="true"/>--%>
<%--<jsp:include page="/include/resource.jsp" flush="true"/>--%>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer="" src="/js/egovframework/cmmn/jquery-3.6.0.min.js"></script>
<script defer="" src="/js/egovframework/cmmn/common-ui.js"></script>

<style>
	body {margin:0;padding-left:0;padding-right:0;padding-bottom:0;padding-top:2mm;}
	.hce {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hme {margin:0;padding:0;position:absolute;}
	.hhe {margin:0;padding:0;position:relative;}
	.hhi {display:inline-block;margin:0;padding:0;position:relative;background-size:contain;}
	.hls {margin:0;padding:0;position:absolute;}
	.hfS {margin:0;padding:0;position:absolute;}
	.hcD {margin:0;padding:0;position:absolute;}
	.hcI {margin:0;padding:0;position:absolute;}
	.hcS {margin:0;padding:0;position:absolute;}
	.hfN {margin:0;padding:0;position:relative;}
	.hmB {margin:0;padding:0;position:absolute;}
	.hmO {margin:0;padding:0;position:absolute;}
	.hmT {margin:0;padding:0;position:absolute;}
	.hpN {display:inline-block;margin:0;padding:0;position:relative;white-space:nowrap;}
	.htC {display:inline-block;margin:0;padding:0;position:relative;vertical-align:top;overflow:hidden;}
	.haN {display:inline-block;margin:0;padding:0;position:relative;}
	.hdu {margin:0;padding:0;position:relative;}
	.hdS {margin:0;padding:0;position:absolute;}
	.hsC {margin:0;padding:0;position:absolute;}
	.hsR {margin:0;padding:0;position:absolute;}
	.hsG {margin:0;padding:0;position:absolute;}
	.hsL {margin:0;padding:0;position:absolute;}
	.hsT {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hsE {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hsA {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hsP {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hsV {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hsO {margin:0;padding:0;position:absolute;}
	.hsU {margin:0;padding:0;position:absolute;overflow:hidden;}
	.hpi {margin:0;padding:0;position:absolute;}
	.hch {margin:0;padding:0;position:absolute;}
	.hcG {margin:0;padding:0;position:absolute;}
	.heq {margin:0;padding:0;position:absolute;}
	.heG {margin:0;padding:0;position:absolute;}
	.htA {margin:0;padding:0;position:absolute;}
	.hvi {margin:0;padding:0;position:absolute;}
	.htb {margin:0;padding:0;position:absolute;}
	.htG {margin:0;padding:0;position:absolute;}
	.hfJ {margin:0;padding:0;position:absolute;}
	.hfG {margin:0;padding:0;position:absolute;}
	.hfB {margin:0;padding:0;position:absolute;}
	.hfR {margin:0;padding:0;position:absolute;}
	.hfC {margin:0;padding:0;position:absolute;}
	.hfO {margin:0;padding:0;position:absolute;}
	.hfL {margin:0;padding:0;position:absolute;}
	.hfM {margin:0;padding:0;position:absolute;}
	.hfE {margin:0;padding:0;position:absolute;}
	.hpl {margin:0;padding:0;position:absolute;}
	.hs {margin:0;padding:0;position:absolute;overflow:visible;}
	.hpa {position:relative;padding:0;overflow:hidden;margin-left:2mm;margin-right:0mm;margin-bottom:2mm;margin-top:0mm;border:1px black solid;box-shadow:1mm 1mm 0 #AAAAAA;}
	.hpa::after {content:'';position:absolute;margin:0;padding:0;left:0;right:0;top:0;bottom:0;background-color:white;z-index:-2;}
	.hrt {display:inline-block;margin:0;padding:0;position:relative;white-space:inherit;line-height:1.1;}
	.hco {display:inline-block;margin:0;padding:0;position:relative;white-space:inherit;}
	.hcc {margin:0;padding:0;position:absolute;}
	.hls {clear:both;}
	[onclick] {cursor:pointer;}
	.cs0 {font-size:10pt;color:#000000;font-family:"바탕";}
	.cs1 {font-size:10pt;color:#000000;font-family:"돋움";}
	.cs2 {font-size:15pt;color:#000000;font-family:"돋움";}
	.cs3 {font-size:20pt;color:#000000;font-family:"휴먼옛체", "한양궁서";}
	.cs4 {font-size:20pt;color:#000000;font-family:"돋움";}
	.cs5 {font-size:30pt;color:#000000;font-family:"돋움";}
	.cs6 {font-size:9pt;color:#000000;font-family:"바탕";}
	.cs7 {font-size:9pt;color:#000000;font-family:"돋움";}
	.cs8 {font-size:18pt;color:#000000;font-family:"굴림";letter-spacing:0.05em;font-weight:bold;}
	.cs9 {font-size:10.52pt;color:#000000;font-family:"굴림";}
	.cs10 {font-size:10.52pt;color:#000000;font-family:"굴림";font-weight:bold;}
	.cs11 {font-size:13pt;color:#000000;font-family:"돋움";letter-spacing:0.11em;}
	.cs12 {font-size:10pt;color:#000000;font-family:"굴림체";letter-spacing:0.11em;}
	.cs13 {font-size:11pt;color:#000000;font-family:"굴림체";letter-spacing:0.11em;}
	.ps0 {text-align:justify;}
	.ps1 {text-align:center;}
	.ps2 {text-align:justify;}
	.ps3 {text-align:center;}
	.ps4 {text-align:center;}
	.ps5 {text-align:justify;}
	.ps6 {text-align:center;}
	.ps7 {text-align:justify;}
	.ps8 {text-align:left;}
	.ps9 {text-align:center;}
	.ps10 {text-align:left;}
	.ps11 {text-align:right;}
	.ps12 {text-align:right;}


	.stamp {
		display: inline-block;
		font-size: 20px;
		font-weight: bold;
		border: 2px solid red;
		border-radius: 10px;
		padding: 10px 20px;
		text-align: center;
		line-height: 1;
		background-color: white;
	}
	@media print {
		body * {
			visibility: hidden;
		}
		#printTable, #printTable * {
			visibility: visible;
		}
		#printTable {
			position: absolute;
			left: 0;
			top: 0;
		}
	}
</style>

</head>
<body>
<div class="content-group" data-apv-yn="${apvYn}" style=" margin-bottom: 80px;">
	<button id="insertApvBtn" type="button" class="btn btn-lg btn-type05 mb-20" style="float: right; margin-right: 30px;">
		<span>결재신청</span>
	</button>

	<button id="updateApvBtn" type="button" class="btn btn-lg btn-type05 mb-20" style="float: right; margin-right: 30px;">
		<span>수정</span>
	</button>

	<button id="updateApvApp" type="button" class="btn btn-lg btn-type05 mb-20" style="float: right; margin-right: 30px;">
		<span>승인</span>
	</button>

	<button id="updateApvReject" type="button" class="btn btn-lg btn-type05 mb-20" style="float: right; margin-right: 30px;">
		<span>반려</span>
	</button>

	<button id="ListApvDds" type="button" class="btn btn-lg btn-type05 mb-20" style="float: right; margin-right: 30px;">
		<span>결재선</span>
	</button>

	<button id="printBtn" type="button" class="btn btn-lg btn-type05 mb-20" onclick="window.print()" style="float: right; margin-right: 30px; margin-bottom: 10px;">
		<span>인쇄하기</span>
	</button>
</div>

<div class="inner-20 mt-30" style=" margin-bottom: 80px;">
	<div class="content-wrap">
		<div class="list-tab-wrap" id=boardList>
			<ul id="boardList">
				<li class="fl tc tit rt-line w30-percent">제목</li>
				<li class="fl tc tit rt-line w70-percent">
					<div class="form-box">
						<div class="frm-form">
							<div class="common-input type-unit" style="margin-top: -14px;">
								<input type="text" id="title" class="ta-l" name="title" title="제목" value="${result[0].title}" placeholder="">
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="hpa" id="printTable" style="width:210mm;height:297mm; margin: auto;">
	<div class="hsR" style="top:26.32mm;left:73.98mm;width:64.01mm;height:11.80mm;">
		<svg class="hs" viewBox="-0.15 -0.15 64.30 12.09" style="left:-0.15mm;top:-0.15mm;width:64.30mm;height:12.09mm;">
			<defs>
				<pattern id="w_00" width="10" height="10" patternUnits="userSpaceOnUse">
					<rect width="10" height="10" fill="rgb(64,68,64)"/>
				</pattern>
			</defs>
			<path fill="url(#w_00)" d="M0,0L63.91,0L63.91,11.70L0,11.70L0,0Z " style="stroke:#404440;stroke-linecap:butt;stroke-width:0.30;"></path>
		</svg>
	</div>
	<div class="hcD" style="left:15mm;top:25mm;">
		<div class="hcI">
			<div class="hls ps3" style="line-height:12.52mm;white-space:nowrap;left:0mm;top:0mm;height:12.52mm;width:180mm;">
				<div class="htb" style="width:64.77mm;height:12.52mm;display:inline-block;position:relative;vertical-align:-15%;line-height:12.52mm;">
					<svg class="hs" viewBox="-2.50 -2.50 69.77 17.52" style="left:-2.50mm;top:-2.50mm;width:69.77mm;height:17.52mm;">
						<defs>
							<pattern id="w_01" width="10" height="10" patternUnits="userSpaceOnUse">
								<rect width="10" height="10" fill="rgb(247,247,247)"/>
							</pattern>
						</defs>
						<path fill="url(#w_01)" d="M0,0L63.78,0L63.78,11.53L0,11.53L0,0Z "></path>
						<path d="M0,0 L0,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M63.78,0 L63.78,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.06,0 L63.85,0" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.06,11.53 L63.85,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M63.78,0 L63.78,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M0,0 L0,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.06,11.53 L63.85,11.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.06,0 L63.85,0" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
					</svg>
					<div class="hce" style="left:0mm;top:0mm;width:63.78mm;height:11.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.10mm;">
								<div class="hls ps4" style="line-height:5.52mm;white-space:nowrap;left:0mm;top:-0.32mm;height:6.35mm;width:57.50mm;">
									<span class="hrt cs8">휴 &nbsp;&nbsp;가 &nbsp;&nbsp;계</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="hls ps0" style="line-height:2.79mm;white-space:nowrap;left:0mm;top:11.45mm;height:3.53mm;width:180mm;"></div>
			<div class="hls ps5" style="line-height:2.79mm;white-space:nowrap;left:0mm;top:16.74mm;height:3.53mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:204.10mm;white-space:nowrap;left:0mm;top:23.27mm;height:204.10mm;width:180mm;">
				<div class="htb" style="width:179.93mm;height:204.10mm;display:inline-block;position:relative;vertical-align:-15%;line-height:204.10mm;">
					<svg class="hs" viewBox="-2.50 -2.50 184.93 209.09" style="left:-2.50mm;top:-2.50mm;width:184.93mm;height:209.09mm;">
						<path fill="url(#w_01)" d="M0,4.70L13.41,4.70L13.41,29.75L0,29.75L0,4.70Z "></path>
						<path fill="url(#w_01)" d="M13.41,4.70L33.78,4.70L33.78,11.73L13.41,11.73L13.41,4.70Z "></path>
						<path fill="url(#w_01)" d="M33.78,4.70L54.16,4.70L54.16,11.73L33.78,11.73L33.78,4.70Z "></path>
						<path fill="url(#w_01)" d="M54.16,4.70L74.53,4.70L74.53,11.73L54.16,11.73L54.16,4.70Z "></path>
						<defs>
							<pattern id="w_02" width="10" height="10" patternUnits="userSpaceOnUse">
								<rect width="10" height="10" fill="rgb(242,242,242)"/>
							</pattern>
						</defs>
						<path fill="url(#w_02)" d="M0,29.75L33.78,29.75L33.78,40.27L0,40.27L0,29.75Z "></path>
						<path fill="url(#w_02)" d="M0,40.27L33.78,40.27L33.78,50.80L0,50.80L0,40.27Z "></path>
						<path fill="url(#w_02)" d="M74.53,40.27L108.11,40.27L108.11,50.80L74.53,50.80L74.53,40.27Z "></path>
						<path fill="url(#w_02)" d="M0,50.80L33.78,50.80L33.78,71.85L0,71.85L0,50.80Z "></path>
						<path fill="url(#w_02)" d="M0,71.85L33.78,71.85L33.78,107.45L0,107.45L0,71.85Z "></path>
						<path fill="url(#w_02)" d="M0,107.45L33.78,107.45L33.78,117.98L0,117.98L0,107.45Z "></path>
						<path fill="url(#w_02)" d="M0,117.98L33.78,117.98L33.78,128.50L0,128.50L0,117.98Z "></path>
						<path fill="url(#w_02)" d="M0,128.50L33.78,128.50L33.78,139.03L0,139.03L0,128.50Z "></path>
						<path d="M0,4.70 L0,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M13.41,4.70 L13.41,29.75" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M33.78,4.70 L33.78,29.75" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M33.78,29.75 L33.78,139.03" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M54.16,4.70 L54.16,29.75" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M74.53,4.70 L74.53,29.75" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M74.53,40.27 L74.53,50.80" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M108.11,40.27 L108.11,50.80" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M178.94,4.70 L178.94,29.75" style="stroke:#FFFFFF;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M178.94,29.75 L178.94,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M-0.05,4.70 L74.74,4.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M13.21,11.73 L74.74,11.73" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,29.75 L179.15,29.75" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M-0.20,40.27 L179.15,40.27" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,50.80 L179.15,50.80" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,71.85 L179.15,71.85" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,107.45 L179.15,107.45" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,117.98 L179.15,117.98" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,128.50 L179.15,128.50" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,139.03 L179.15,139.03" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
						<path d="M-0.20,203.11 L179.15,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M178.94,4.70 L178.94,29.75" style="stroke:#FFFFFF;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M178.94,29.75 L178.94,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M0,4.70 L0,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M-0.20,203.11 L179.15,203.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
						<path d="M-0.05,4.70 L74.74,4.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
					</svg>
					<div class="hce" style="left:0mm;top:0mm;width:13.41mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:12.42mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:13.41mm;top:0mm;width:20.38mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:0mm;width:20.38mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:54.16mm;top:0mm;width:20.38mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:74.53mm;top:0mm;width:19.42mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps6" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:18.43mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.95mm;top:0mm;width:19.15mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:18.15mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:113.10mm;top:0mm;width:11.60mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:10.61mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:124.70mm;top:0mm;width:17.89mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:16.91mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:142.59mm;top:0mm;width:18.50mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:17.51mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:161.09mm;top:0mm;width:17.85mm;height:4.70mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:16.86mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:4.70mm;width:13.41mm;height:25.05mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:4.60mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:12.42mm;">
									<span class="hrt cs10">소속</span>
								</div>
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:5.39mm;height:3.71mm;width:12.42mm;"></div>
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:10.96mm;height:3.71mm;width:12.42mm;">
									<span class="hrt cs10">본부</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:13.41mm;top:4.70mm;width:20.38mm;height:7.03mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:1.16mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<span class="hrt cs10">담 당</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:4.70mm;width:20.38mm;height:7.03mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:1.16mm;">
								<div class="hls ps1 " style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<span class="hrt cs10 department-manager">${result[0].approver1}</span>
									<input type="hidden" id="pUserNmHidden" name="pUserNmHidden" value="${result[0].approverId1}">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:54.16mm;top:4.70mm;width:20.38mm;height:7.03mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:1.16mm;">
								<div class="hls ps1 " style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<span class="hrt cs10 head-of-department">${result[0].approver2}</span>
									<input type="hidden" id="pUserNmHidden1" name="pUserNmHidden1" value="${result[0].approverId2}">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:74.53mm;top:4.70mm;width:104.41mm;height:25.05mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:10.17mm;">
								<div class="hls ps6" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:103.42mm;"></div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:13.41mm;top:11.73mm;width:20.38mm;height:18.02mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps0" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<input class="stamp" type="text" id="pUserNmSign" name="pUserNmSign" style="height: 66px; width: 74px; font-size: 25px; text-align: center;" readonly>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:11.73mm;width:20.38mm;height:18.02mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps0" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<input class="stamp" type="text" id="pUserNmSign1" name="pUserNmSign1" style="height: 66px; width: 74px; font-size: 25px; text-align: center;" readonly>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:54.16mm;top:11.73mm;width:20.38mm;height:18.02mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps0" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:19.39mm;">
									<input class="stamp" type="text" id="pUserNmSign2" name="pUserNmSign2" style="height: 66px; width: 74px; font-size: 25px; text-align: center;" readonly>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:29.75mm;width:33.78mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">소 속 본 부</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:29.75mm;width:145.16mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<input type="text" name="deptNm"  value="${result[0].deptNm}" data-dept-cd="${result[0].deptCd}" style="height: 38px;width: 100%;font-size: 21px; font-family: 굴림; text-align: center; margin-top: -11px;" readonly="">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:40.27mm;width:33.78mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">성 명</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:40.27mm;width:40.75mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:39.77mm;">
									<input type="text" name="userNm"  value="${result[0].userNm}" data-user-id="${result[0].userId}" style="height: 38px;width: 100%;font-size: 21px; font-family: 굴림; text-align: center; margin-top: -11px;" readonly="">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:74.53mm;top:40.27mm;width:33.57mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:32.58mm;">
									<span class="hrt cs10">직 &nbsp;&nbsp;&nbsp;위</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.11mm;top:40.27mm;width:70.84mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps0" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:69.85mm;">
									<input type="text" name="posiNm"  value="${result[0].posiNm}" data-posi-cd="${result[0].posiCd}" style="height: 38px;width: 100%;font-size: 21px; font-family: 굴림; text-align: center; margin-top: -11px;" readonly="">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:50.80mm;width:33.78mm;height:21.05mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:8.17mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:32.79mm;">
									<span class="hrt cs10">기 &nbsp;&nbsp;&nbsp;간</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:50.80mm;width:145.16mm;height:21.05mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:8.17mm;">
								<div class="hls ps8" style="padding-left:3.53mm;line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<!-- <span class="hrt cs9">202 &nbsp;년 &nbsp;&nbsp;월 &nbsp;&nbsp;일 &nbsp;&nbsp;요일 &nbsp;- &nbsp;202 &nbsp;년 &nbsp;&nbsp;월 &nbsp;&nbsp;&nbsp;일 &nbsp;&nbsp;&nbsp;요일 &nbsp;&nbsp;&nbsp;( &nbsp;) 일간</span> -->
									<input type="text" name="duration" id="durationInput" style="height: 77px;width: 546px;font-size: 14px; font-family: 굴림; text-align: center; margin-top: -31px;margin-left: -14px;" >
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:71.85mm;width:33.78mm;height:35.60mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:15.45mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">사 유</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:71.85mm;width:145.16mm;height:35.60mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:15.45mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<input type="text" name="content" id="contentInput" value="${result[0].content}" style="height: 134px;width: 547px;font-size: 14px; font-family: 굴림; text-align: center; margin-top:-60px;margin-left:-1px;" >
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:107.45mm;width:33.78mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">업 무 대 체 자</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:107.45mm;width:145.16mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<input type="text" name="subNm" id="subNmInput" class="hrt cs10" value="${result[0].subNm}" style="border:none; width:100%; margin-top: -11px; height: 37px;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:117.98mm;width:33.78mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">비 상 연 락 망</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:117.98mm;width:145.16mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<input type="text" class="hrt cs10" name= "emgContact" value="${result[0].emgContact}" style="border:none; width:100%; margin-top: -11px; height: 37px;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:128.50mm;width:33.78mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps7" style="line-height:2.95mm;white-space:nowrap;left:2.65mm;top:-0.19mm;height:3.71mm;width:27.49mm;">
									<span class="hrt cs10">대 처 분</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:33.78mm;top:128.50mm;width:145.16mm;height:10.53mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI" style="top:2.91mm;">
								<div class="hls ps1" style="line-height:2.95mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.71mm;width:144.17mm;">
									<input type="text" name="disposition" value="${result[0].disposition}" class="hrt cs10" placeholder="예) 연차, 경조휴가, 공가" style="border:none; width:100%; margin-top: -11px; height: 37px;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:139.03mm;width:178.94mm;height:64.08mm;">
						<div class="hcD" style="left:0.49mm;top:0.49mm;">
							<div class="hcI">
								<div class="hls ps9" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:-0.19mm;height:3.71mm;width:170.90mm;"></div>
								<div class="hls ps9" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:7.24mm;height:3.71mm;width:170.90mm;">
									<span class="hrt cs9">본인은 위와 같은 사유로 인하여 휴가계를 제출하오니 재가하여 주시기 바랍니다.&nbsp;</span>
								</div>
								<div class="hls ps10" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:14.66mm;height:3.71mm;width:170.90mm;"></div>
								<div class="hls ps9" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:22.08mm;height:3.71mm;width:170.90mm;"></div>
								<div class="hls ps9" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:29.50mm;height:3.71mm;width:170.90mm;"></div>
								<div class="hls ps11" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:36.93mm;height:3.71mm;width:156.79mm;">
									<input type="text" name="appDate" id="appDateInput" style="height: 22px;width: 172px;font-size: 14px; font-family: 굴림; margin-top: -31px; border: none;" >
								</div>
								<div class="hls ps11" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:48.06mm;height:3.71mm;width:156.79mm;">
									<span class="hrt cs9">신청자</span>
									<input type="text" name="appNm" id="applicantNmInput" value="${result[0].appNm}" style="height: 22px;width: 172px;font-size: 14px; font-family: 굴림; border: none; margin-top: -3px; text-align: center;" >
									<span class="hrt cs9">(印)</span>
								</div>
								<div class="hls ps12" style="line-height:2.95mm;white-space:nowrap;left:3.53mm;top:59.19mm;height:3.71mm;width:156.79mm;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="hls ps0" style="line-height:3.76mm;white-space:nowrap;left:0mm;top:228.90mm;height:4.59mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:3.76mm;white-space:nowrap;left:0mm;top:235.79mm;height:4.59mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:3.76mm;white-space:nowrap;left:0mm;top:242.67mm;height:4.59mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:2.79mm;white-space:nowrap;left:0mm;top:249.61mm;height:3.53mm;width:180mm;"></div>
		</div>
	</div>
</div>
<div class="hpa" style="width:210mm;height:297mm; margin: auto;">
	<div class="hcD" style="left:15mm;top:25mm;">
		<div class="hcI">
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:-0.19mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;* 연 &nbsp;&nbsp;&nbsp;차 : 일반휴가, 병결, 명절 때 임원들의 결정에 의해 지정되는 휴가 등 &nbsp;</span>
			</div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:5.63mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;평상시 사용하는 휴가를 뜻합니다.&nbsp;</span>
			</div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:11.46mm;height:3.88mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:17.29mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;* 경조휴가 : 회사에서 지정한 경조사가 발생했을 시 정해진 일수만큼 사용하는</span>
			</div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:23.12mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사용하는 휴가를 뜻합니다.&nbsp;</span>
			</div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:28.95mm;height:3.88mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:34.77mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;* 공 &nbsp;&nbsp;&nbsp;가 : 포상휴가, 예비군훈련, 외부교육 등을 뜻합니다.&nbsp;</span>
			</div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:40.60mm;height:3.88mm;width:180mm;"></div>
			<div class="hls ps0" style="line-height:3.10mm;white-space:nowrap;left:0mm;top:46.43mm;height:3.88mm;width:180mm;">
				<span class="hrt cs13">&nbsp;</span>
			</div>
		</div>
	</div>
</div>

<!-- <div class="layerpop __alert pop-alert" id="__alert">
	<div class="pop-wrap">
		<h3 class="blind">전자결재신청</h3>
		button type="button" class="pop-close" onclick="LayerPopup.close();">닫기</button
		<div class="pop-content">
			<div class="pc-wrap">
				<p class="pc-tit">안내</p>
				<p class="pc-msg">요청이 정상적으로 처리되었습니다.</p>
			</div>
			<div class="btn-group">
				<button type="button" class="btn btn-float btn-primary1" onclick="LayerPopup.close('channel-pop');">확인</button>
			</div>

		</div>
	</div>
</div> -->

<!-- <div class="layerpop __confirm pop-alert" id="__confirm">
	<div class="pop-wrap">
		<h3 class="blind">팝업</h3>
		button type="button" class="pop-close" onclick="LayerPopup.close();">닫기</button
		<div class="pop-content">
			<div class="pc-wrap">
				<p class="pc-tit">전자결재신청</p>
				<p class="pc-msg">결재신청 진행하시겠습니까?</p>
			</div>
			<div class="btn-group">
				<button type="button" class="btn btn-float btn-cancel sm-txt">닫기</button>
				<button type="button" class="btn btn-float btn-primaryConfirm">확인</button>
			</div>

		</div>
	</div>
</div> -->

<script>

	var apvCheckCode = ""; // 결재신청:05, 수정:00, 반려:02, 승인:01
	var apvCnt = 0;
	var apvCheck = "";

	// JSP를 통해 전달된 result 객체의 값을 JavaScript 변수로 전달
	var apvStat = '${apvSignResult[0].apvStat}';
	var apvStat1 = '${apvSignResult[1].apvStat}';
	var apvNm = '${apvSignResult[0].apvNm}';
	var apvNm1 = '${apvSignResult[1].apvNm}';
	var apvSignUserNm1 = '${result[0].approverNm1}';
	var apvSignUserNm2 = '${result[0].approverNm2}';
	var apvSignUserNm3 = '${result[0].approver3}';

	// pUserNmSign 요소들 가져오기
	var pUserNmSignInput = document.getElementById('pUserNmSign');
	var pUserNmSignInput1 = document.getElementById('pUserNmSign1');
	var pUserNmSignInput2 = document.getElementById('pUserNmSign2');
	console.log("apvNm 이름 : "+apvNm);
	console.log("apvSignUserNm1 이름 : "+apvSignUserNm1);
	console.log("apvSignUserNm2 이름 : "+apvSignUserNm2);
	pUserNmSignInput.value = '확인';

	if (apvNm === apvSignUserNm1 && apvStat === '01') {
		pUserNmSignInput1.value = '확인';
	} else if (apvNm1 === apvSignUserNm1 && apvStat1 === '01') {
		pUserNmSignInput1.value = '확인';
	}

	if (apvNm === apvSignUserNm2 && apvStat === '01') {
		pUserNmSignInput2.value = '확인';
	} else if (apvNm1 === apvSignUserNm2 && apvStat1 === '01') {
		pUserNmSignInput2.value = '확인';
	}

	/*    if (apvNm === apvSignUserNm3 && apvStat === '01') {
           pUserNmSignInput2.value = '확인';
       }  */

	// 기간의 값이 있을경우 그 값을 셋팅, 아닐경우 기본값 셋팅
	document.addEventListener("DOMContentLoaded", function() {
		var duration = "${result[0].duration}";
		var inputElement = document.getElementById("durationInput");
		var defaultValue = "202 년  월  일  요일 - 202 년  월  일  요일  (  ) 일간";

		console.log(duration);
		if (!duration.trim()) {
			inputElement.value = defaultValue;
		} else {
			inputElement.value = duration;
		}

		var appDate = "${result[0].appDate}";
		var inputElement2 = document.getElementById("appDateInput");
		var defaultValue2 = "  년   월   일";

		if (!appDate.trim()) {
			inputElement2.value = defaultValue2;
		} else {
			inputElement2.value = appDate;
		}

		// .content-group 요소의 data-apv-yn 값을 가져옴
		var contentGroup = document.querySelector(".content-group");
		var apvYn = contentGroup.getAttribute("data-apv-yn");

		// 버튼 요소들
		var insertApvBtn = document.getElementById("insertApvBtn"); // 결재신청버튼
		var updateBtn = document.getElementById("updateBtn"); // 수정버튼
		var listApvDdsBtn = document.getElementById("ListApvDds"); // 결재선버튼
		var printBtn = document.getElementById("printBtn"); // 인쇄버튼

		// apvYn 값에 따라 버튼 표시/숨김 처리
		if (apvYn === "Y") {
			insertApvBtn.style.display = "none";
			listApvDdsBtn.style.display = "none";
			printBtn.style.display = "block";
			updateApvBtn.style.display = "block";
			updateApvApp.style.display = "block";
			updateApvReject.style.display = "block";
		} else if (apvYn === "N") {
			insertApvBtn.style.display = "block";
			listApvDdsBtn.style.display = "block";
			printBtn.style.display = "block";
			updateApvBtn.style.display = "none";
			updateApvApp.style.display = "none";
			updateApvReject.style.display = "none";
		} else if (apvYn === "C") { // 결재완료함이나 반려함에서 넘어왔을때 인쇄하기 버튼만 보이게하기
			insertApvBtn.style.display = "none";
			listApvDdsBtn.style.display = "none";
			printBtn.style.display = "block";
			updateApvBtn.style.display = "none";
			updateApvApp.style.display = "none";
			updateApvReject.style.display = "none";
		}
	});

	$("#ListApvDds").click(function() {
		// "/cmmn/apv/selectApvDdsPosting.do"를 호출하는 팝업 창 열기
		var url = "/cmmn/apv/selectApvDdsPosting.do";
		var popupWindow = window.open(url, "_blank", "width=800,height=600");
		if (!popupWindow || popupWindow.closed || typeof popupWindow.closed == "undefined") {
			alert("팝업 창이 차단되었습니다. 팝업 창을 허용해주세요.");
		}
	});

	// 팝업창에서 결재선 이름, 아이디 가져오기
	function receiveSelectedValues(selectedValues) {
		console.log("길이확인" + selectedValues.length);
		apvCnt = selectedValues.length;
		if (selectedValues && selectedValues.length > 0) {
			selectedValues.forEach((value, index) => {
				const userNm = value.userNm;
				const userId = value.userId;
				const posiNm = value.posiNm;
				console.log("포지션 확인 : " + posiNm);
				console.log("아이디 확인 : " + userId);
				console.log("성명 확인 : " + userNm);
				if (index === 0) {
					const headOfDepartment = document.querySelector('.head-of-department');
					headOfDepartment.textContent = posiNm;
					headOfDepartment.dataset.userId = userId;
					document.getElementById('pUserNmHidden').value = userNm;
				} else if (index === 1) {
					const departmentManager = document.querySelector('.department-manager');
					departmentManager.textContent = posiNm;
					departmentManager.dataset.userId = userId;
					document.getElementById('pUserNmHidden1').value = userNm;
				}
			});
		}
	}

	/* 버튼 이벤트 라인@@@@@@@@@@@@@@@@@@@@@@@@@@ */
	// 결재신청 버튼
	$("#insertApvBtn").click(function() {
		var title = $("input[name=title]").val();
		console.log("title : "+title);
		if (title === "") {
			alert("제목을 입력하세요.");
			return;
		}
		apvCheckCode = "05";
		LayerPopup.open('__confirm');

	});
	// 수정버튼
	$("#updateApvBtn").click(function() {
		apvCheckCode = "00";
		$("#__confirm").find(".pop-wrap").find(".pop-content").find(".pc-msg").html("수정 하시겠습니까?")
		LayerPopup.open('__confirm');

	});

	// 결재 승인
	$("#updateApvApp").on("click", function() {
		apvCheckCode = "01";
		$("#__confirm").find(".pop-wrap").find(".pop-content").find(".pc-msg").html("결재승인 처리 하시겠습니까?")
		LayerPopup.open('__confirm');
	}); // updateApvApp 결재승인 END

	// 결재 반려
	$("#updateApvReject").on("click", function() {
		apvCheckCode = "02";
		$("#__confirm").find(".pop-wrap").find(".pop-content").find(".pc-msg").html("결재반려 처리 하시겠습니까?")
		LayerPopup.open('__confirm');
	}); // updateApvApp 결재반려 END

	// 알림창라인@@@@@@@@@@@@@@@@
	// confirm 확인 이벤트
	$(".btn-primaryConfirm").click(function(){

		if (apvCheckCode === "05"){ // 결재신청버튼
			console.log("결재신청 버튼 클릭 @!@@@@");
			apvCheck = "insert";
			insertUpdateData();
			// 결재신청 insert END@@@
		} else if (apvCheckCode === "00"){ // 수정버튼 로직
			apvCheck = "update";
			insertUpdateData();
		} else if (apvCheckCode === "01"){ // 승인버튼 로직
			console.log("승인버튼 로직@@");
			updateBtnAjax();
		} else if (apvCheckCode === "02"){ // 반려버튼 로직
			updateBtnAjax();
		}

	});

	// confirm 취소버튼
/* 	$("#__confirm .btn-cancel").click(function() {
		LayerPopup.close('__confirm');
	}); */


	/* $(".btn-primary1").click(function() {
		LayerPopup.close('__alert');
		window.location.href = '/cmmn/apv/selectApvAppPosting.do';
	}); */

/* 	function insertUpdateData() {

		var pDetpNm = $("input[name=deptNm]").val();
		var pDetpCd = $("input[name=deptNm]").data("dept-cd");
		var pUserNm = $("input[name=userNm]").val();
		var pUserId = $("input[name=userNm]").data("user-id");
		var pPosiNm = $("input[name=posiNm]").val();
		var pPosiCd = $("input[name=posiNm]").data("posi-cd");
		var pDuration = $("input[name=duration]").val();
		var pContent = $("input[name=content]").val();
		var pSubNm = $("input[name=subNm]").val();
		var pEmgContact = $("input[name=emgContact]").val();
		var pDisposition = $("input[name=disposition]").val();
		var pAppDate = $("input[name=appDate]").val();
		var pAppNm = $("input[name=appNm]").val();
		if (apvCheck === "insert"){
			// var approver1 = $(".hrt.cs10.department-manager").text();
			var approver1UserId = document.querySelector(".hrt.cs10.department-manager").dataset.userId;
			// var approver2 = $(".hrt.cs10.head-of-department").text();
			var approver2UserId = document.querySelector(".hrt.cs10.head-of-department").dataset.userId;
		} else if (apvCheck === "update"){
			// var approver1 = $(".hrt.cs10.department-manager").text();
			var approver1UserId = $("input[name=pUserNmHidden1]").val();
			// var approver2 = $(".hrt.cs10.head-of-department").text();
			var approver2UserId = $("input[name=pUserNmHidden]").val();
		}
		var pTitle = $("input[name=title]").val();
		var documentNum = '${result[0].documentNum}';
		console.log("documentNum 카운트 : "+documentNum);
		console.log("approver2UserId 카운트 : "+approver2UserId);
		console.log("approver1UserId 카운트 : "+approver1UserId);

		$.ajax({
			url: '/cmmn/doc/insertLeaveRequest.do',
			type: 'POST',
			data: {detpNm: pDetpNm,
				deptCd: pDetpCd,
				userNm: pUserNm,
				posiCd: pPosiCd,
				duration: pDuration,
				content: pContent,
				subNm: pSubNm,
				title: pTitle,
				apvCnt: apvCnt,
				emgContact: pEmgContact,
				disposition: pDisposition,
				appDate: pAppDate,
				approver1: approver1UserId,
				approver2: approver2UserId,
				appNm: pAppNm,
				apvCheck: apvCheck,
				documentNum: documentNum
			},
			success: function(response) {
				console.log(response);
				LayerPopup.close('__confirm');
				LayerPopup.open('__alert');
			},
			error: function(xhr, status, error) {
				console.error(xhr.responseText);
			}
		});
	} */

	// 결재 승인, 반려
	/* function updateBtnAjax() {
		var documentNum = '${result[0].documentNum}'
		var apvCd = '${result[0].apvCd}'
		var apvTypeCd = '${result[0].apvTypeCd}'
		var docCheck = "휴가계";

		$.ajax({
			url: '/cmmn/doc/updateApvApp.do',
			type: 'POST',
			data: {
				documentNum: documentNum,
				apvCd: apvCd,
				apvTypeCd: apvTypeCd,
				apvStat: apvCheckCode,
				docCheck: docCheck
			},
			success: function(response) {
				LayerPopup.close('__confirm');
				LayerPopup.open('__alert');
			},
			error: function(xhr, status, error) {
				console.error(xhr.responseText);
			}
		});   // ajax END
	} */


</script>
</body>
</html>








