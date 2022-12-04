# Gramming

- Splash Screen  
![splashScreen – 1](https://user-images.githubusercontent.com/81023768/205496489-c936c9b9-a375-4dbb-9c3d-d897b0bcfaac.png)  

- Sign In / Sign Up  
![signIn – 1](https://user-images.githubusercontent.com/81023768/205496498-1d36da0e-1453-49ec-8bc9-7537615a1d7b.png)
![signUp – 1](https://user-images.githubusercontent.com/81023768/205496496-ff0dd648-bf42-4c0f-9a1d-a59bea9af82b.png)  

- Menu  
![menu – 1](https://user-images.githubusercontent.com/81023768/205496524-628b561b-715b-479c-9983-f5124626f879.png)
![menu – 4](https://user-images.githubusercontent.com/81023768/205496526-f216f1b7-fc10-40bd-aacc-26df6c2873a2.png)
![menu – 3](https://user-images.githubusercontent.com/81023768/205496527-f4dcb23f-094c-4e66-9fa8-5e3d5d096e58.png)
![menu – 5](https://user-images.githubusercontent.com/81023768/205496529-a1a4a970-2907-4efd-a1ad-2f97271b0668.png)  

- Main  
![main-1 – 2](https://user-images.githubusercontent.com/81023768/205496584-16dae22f-3a0e-4f04-85d7-9de8d42a3a10.png)
![main-1 – 4](https://user-images.githubusercontent.com/81023768/205496586-8108056a-dca3-42a5-97f4-e2252de0744b.png)  

- Memo  
![main-1 – 3](https://user-images.githubusercontent.com/81023768/205496622-cd6e2966-f2d4-4986-9726-965904367357.png)
![main-1 – 6](https://user-images.githubusercontent.com/81023768/205496625-f49acee8-c1e1-4018-8e54-56a92fd45d31.png)  

- Add  
![main-1 – 5](https://user-images.githubusercontent.com/81023768/205496636-6374037e-8ecb-4fe0-bf06-1afe6b5e8684.png)
![main-1 – 12](https://user-images.githubusercontent.com/81023768/205496641-9d23ef14-b408-405f-9946-fd06964654d7.png)
![main-1 – 13](https://user-images.githubusercontent.com/81023768/205496642-45bd7f62-3054-403e-8464-46a5f51dd49c.png)  

- Update  
![main-1 – 8](https://user-images.githubusercontent.com/81023768/205496660-5b4a307c-a12d-4a56-b816-f47facc9d623.png)
![main-1 – 11](https://user-images.githubusercontent.com/81023768/205496662-b15f3277-33a9-447e-b509-bb174af8d5f0.png)
![main-1 – 14](https://user-images.githubusercontent.com/81023768/205496664-63392194-ce5c-46a2-8af2-703fa4bb1a76.png)
![main-1 – 10](https://user-images.githubusercontent.com/81023768/205496666-f800ca84-400f-4edb-b21e-260155db6ed7.png)  
  


  

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


