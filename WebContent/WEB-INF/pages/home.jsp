<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<jsp:include page="import/header.jsp"></jsp:include>
<style>
	

	img.event-img{
		width:100px;
		height:90px;
		margin-top:5px;
		margin-bottom: 10px;
		margin-left:5px;
		margin-right: 10px;
		float:left;
	}
	p.event-des{
		text-align: justify;
		font-style: italic;
		color: #A7A5A5;
		word-wrap: break-word;
		padding-right: 10px;
	}
	h4.event-name{
		margin:0;
		line-height: 30px;
	}
	span.event-img-wrapper{
		
		height:120px;
		
		
	}
	p.event-date{
		font-style:italic;
		color:gray;
		line-height:10px;
		font-size: 10px;
		margin-left:5px;
	}
	
	span.event-delete{
		width: 10px;
		height:10px;
		position:absolute;
		right: 5px;
		top:5px;
		display:none;
	}
	.sun-event:hover .event-delete{
		display:block;
	}
	div.event-img-box{
		height: 110px;
		
	}
	div.event-box-detail{
			
	}
	
</style>
</head>
<body  ng-app="myApp" ng-controller="myCtrl">

	<div class="sun-wrapper">
		<div class="sun-header">
			<jsp:include page="element/fixedbar.jsp"></jsp:include>
		</div>
		
		<div class="sun-content">
				
			
				<div class="data">
					<div class="container-fluid event-list">
						<div class="col-sm-12">
						
							<div ng-repeat="event in events" style="position:relative" class="sun-event services_block col-sm-6 col-lg-4 col-xs-12 " >
								<div class="row">
									<div class="event-img-box col-sm-12">
										<span class="event-delete">
											<i  class="fa fa-remove"></i>
										</span>
										<span class="event-delete-phone">
											<i  class="fa fa-remove" style="display:none" ></i>
										</span>
										<span class="event-img-wrapper">
											<img src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ3TbEJkubLP_qomeNunFXpKrweFBAitDgsGGADiKVzNICNZ5a6" class="event-img"/>
											<h4 class="event-name">{{event.event_name}}</h4>
											<p class="event-des">
											{{ event.description | limitTo: limitValue }}{{event.description.length > limitValue ? '...' : ''}}
											</p>
										</span>
									
											
									</div>
									<div class="event-box-detail col-sm-12" >
										<div style="clear:both"></div>
										<div class="pull-left">
											<p class="event-date">Created: {{ event.create_date | date:'d MMM y'}}</p>
											<p class="event-date">Last Modified: {{ event.last_modify_date | date:' d MMM y'}}</p>
										</div>
										<div class="pull-right">
											<button type=""></button>
										</div>									
									</div>
									<div style="clear:both"></div>
																	
								</div>
							</div>
										
						</div>					
					</div>
					
				</div>
		</div>
		
		<div class="sun-footer">
		
		</div>
				
	</div>
 	<jsp:include page="import/footer.jsp"></jsp:include>
 	<script>
 
	var app = angular.module('myApp', []);
	app.controller('myCtrl', function($scope, $http,$location){
		
		$http.defaults.headers.common.Authorization = 'Basic YXBpOmFrbm5ld3M=' ;
		$scope.domain = $location.protocol()+"://"+$location.host()+":"+$location.port();
		$scope.webbaseurl = $scope.domain + "/EventManagementSystem/";
		$scope.baseurl = $scope.domain + "/EventManagementAPI/";
		
		$scope.events = [];
		
		
		$scope.userid = 0;
		$scope.page = 1;
		$scope.row = 10;
		$scope.status = 1;
		
		$scope.limitValue = 0;
		$scope.screen= window.innerWidth;
		$scope.trimString= function(){
			alert($scope.screen);
			if($scope.screen >= 500){
				$scope.limitValue = 100;
			}else{
				$scope.limitValue = 20;				
			}
			
		}
		$scope.trimString();
		$scope.listEvents = function(){
			/* if(!($scope.searchkey == '' || $scope.searchkey==null)){
				$scope.listSearchArticles($scope.searchkey);
				return;
			}
			$scope.triggerpage++; */
		alert();
			$http({
                method: "GET",
                url: $scope.baseurl + "api/event/1/"+$scope.page+"/"+$scope.row+"/"+$scope.status+"/"
            })
            .success(function (response) { 	
            	if(response.RESPONSE_DATA.length == 0){
            		console.log('no article..!');              		
            	}
            	//alert(response.RESPONSE_DATA);
	    		/* $scope.Totalrecord = response.TOTAL_RECORDS;
		    		 $scope.articles=response.RESPONSE_DATA; 		    		 
		    		 $('#display').bootpag({total: response.TOTAL_PAGES });
		    		 if($scope.triggerpage > 1){
		    			 return;
		    		 }
		    		 $scope.loadpagination();	 */	
            	angular.forEach(response.RESPONSE_DATA, function(data, key) {
             		  $scope.events.push(data);
  		    	});
		    		 alert($scope.events);
		    });
		};
		$scope.listEvents();
		
	});
		
  
  </script>
</body>
</html>