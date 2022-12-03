# Gramming
  
![splashScreen](https://user-images.githubusercontent.com/81023768/203576310-af2b0652-81cf-4eda-a8ce-c7b1c6131dd2.png)  


![signIn](https://user-images.githubusercontent.com/81023768/203576344-32aedb81-f5ef-479d-8acd-6c97a8d7994c.png)
![signUp](https://user-images.githubusercontent.com/81023768/203576359-689686c5-a29d-40ca-a82d-1199935f373e.png)  

![menu – 1](https://user-images.githubusercontent.com/81023768/205443293-df2c76ee-66be-486a-a583-18057c73b6af.png)  
![menu – 2](https://user-images.githubusercontent.com/81023768/205443297-0fa66532-1940-4602-ac2d-40b204a425d0.png)  
![menu – 3](https://user-images.githubusercontent.com/81023768/205443298-de5227e9-d551-495e-96d6-fd7d2cd94a4a.png)  

![main-1 – 1](https://user-images.githubusercontent.com/81023768/205443316-7ae676ef-6882-4330-9206-7e0aa6afc310.png)  
![main-1 – 2](https://user-images.githubusercontent.com/81023768/205443314-3bb258a0-f293-4054-85f8-9973259d484b.png)  


![memo-1](https://user-images.githubusercontent.com/81023768/205443323-b692046d-1380-4853-af0e-822a2ff05297.png)  

![add 1](https://user-images.githubusercontent.com/81023768/205443328-8ed200a4-c5c0-43a0-a9c9-a0a6a688f726.png)  



  

### DB구조

- e-mail `collection`
	- menu 
		- [recipe1, recipe2, recipe3 ...]
		- recipe collection
			- recipe1
				- [{key:value}...]
			- recipe2
				- [{key:value}...]
			- recipe3
				- [{key:value}...]
- menu page
: menu를 선택해서 main page로 이동한다

- main page
  - initState할 때 recipe list만 불러오고 리스트의 첫번 째 요소의 String를 키값으로 recipe를 찾아와서 배치한다
	- 레시피의 이름(String)을 키값으로 recipe list에서 개별 레시피를 불러오는 event를 수행한다

- add page  
: 해당 페이지의 menu list `collection`에 recipe list `doc`, recipe `doc`을 더한다

- update page  
	- ReorderableListView 위젯을 통해 recipe list를 정리할 수 있다
	- 상세 레시피 내용도 ReorderableListView 위젯을 통해 드래그앤 드롭이 가능하도록 하고 `List<Map<String, dynamic>>` 형태로  관리한다
	- 레시피 삭제 기능도 여기서 수행한다


- 


