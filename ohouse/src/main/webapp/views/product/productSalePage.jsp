<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product/productCategoryPage.css">
</head>
<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <header>
        <%@ include file="../common/header.jsp" %>
    </header>
    <div align="center">
        <div id="pc-content">
            <div class="pc-sale pc-header" id="pc-deal-header">
                <span class="pc-category" align="center">오늘의딜</span>
            </div>
            <div class="pc-sale pc-header" id="pc-deal-header">
                <h4 class="pc-gray">전체 <span class="pc-gray">${psList.size()}</span>개</h4>
            </div>
            <div class="pc-sale" id="pc-deal-contents">
                <c:forEach var="ps" items="${psList}">
                    <div class="pc-sale-content">
                        <div class="pc-sale-img">
                            <img src="${contextPath}/${ps.productThumbnail}">
                            <button type="button">
                                <img src="${contextPath}/resources/img/product/pm-bookmark.png" width="40px" onclick="changeBookmark(this)">
                            </button>
                        </div>

                        <script>
                            function changeBookmark(_this){
                                const contextPath = "${pageContext.request.contextPath}";
                                const src = _this.src;
                                const bookmarkImage = contextPath + "/resources/img/product/pm-bookmark.png";
                                const checkedBookmarkImage = contextPath + "/resources/img/product/pm-bookmark-checked.png";
    							
                                
                                if (src.includes("pm-bookmark.png")) {
                                    _this.src = checkedBookmarkImage;
                                    const membersNo = "${loginUser.membersNo}"
                                    $.ajax({
                                        url : "scrap.pr",
                                        data : {
                                            mNo : membersNo,
                                            pNo : "${ps.productId}"
                                        },
                                        success : function(result){
                                            console.log("스크랩 성공.")
                                        },
                                        error : function(){
                                            console.log("스크랩 실패")
                                        }       
                                    })
                                } else {
                                    _this.src = bookmarkImage;

                                }
                            }
                        </script>

                        <div class="pc-sale-text">
                            <div class="pc-company">
                                ${ps.companyName}
                            </div>
                            <div class="pc-title">
                                ${ps.productName}
                            </div>
                            <div class="pc-price">
                                <span class="pc-color">${ps.sale}%</span>
                                <span><fmt:formatNumber value="${ps.productPrice}" /></span>
                            </div>
                            <div class="pc-review">
                                <img src="${pageContext.request.contextPath}/resources/img/product/star.png" width="15px">
                                <span class="pc-score">${ps.ratingAvg}</span>
                                <span class="pc-gray">리뷰</span>
                                <span class="pc-gray">${ps.reviewCount}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>  
        </div>
    </div>
    <footer>
        <%@ include file="../common/footer.jsp" %>
    </footer>
</body>
</html>