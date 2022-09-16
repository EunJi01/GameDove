# Gamepedia  

### 앱 소개/특징
#### NewGameView / RatingGameView
* [API](https://rawg.io/apidocs)통신을 통해 게임의 목록을 보여준다. --> 하루에 한번만 통신하는 구조로 구성
* 탭바 컨트롤러를 활용해 신작 게임/인기 게임을  볼 수 있다.
* 찾는 게임이 보이지 않을 경우 검색하여 찾아볼 수 있다. -> 푸쉬 후 새로운 뷰에서 검색? --> 검색 결과에서 키워드의 색을 바꿔준다.
* 특정 플랫폼의 게임만 모아볼 수 있도록 필터링이 가능하며 해당 옵션의 적용 여부는 네비게이션 바 타이틀로 확인할 수 있다.
* 날짜 필터 옵션 추가 (최근 1주, 한달, 6개월, 1년, 3년 내 출시작)
#### DetailView (+WebView)
* 셀을 선택하면 세부 화면으로 이동하며, 게임의 세부 정보를 보여준다.
* 웹뷰로 연결할 수 있는 버튼이 있고 해당 버튼을 누르면 예고편을 볼 수 있다.
#### FavoritesView
* 탭바에 즐겨찾기 탭을 추가하고, 즐겨찾기한 게임들은 여기서 모아볼 수 있다.
* 디테일뷰에서 star 버튼을 누를 경우 토스트 메세지를 띄우고 해당 게임의 정보가 Realm으로 저장된다.
-------------
### 앱 UI/UX
![스크린샷 2022-08-30 오후 7 43 50](https://user-images.githubusercontent.com/92143918/187417082-522e3efd-3ff9-4796-bca8-8305659b5a8e.png)  
-------------
### 앱 기능
* ✅ 다국어 지원 (한영일)
#### NewGameView / RatingGameView / UpcomingGameView (TabBar)
* ✅ API 통신 ⭐️매우 중요⭐️ ---> 우선 신작 모아보기를 구현 후, 마지막에 나누기
* API 통신 ⭐️매우 중요⭐️ ---> 상태 코드나 연결 상태가 좋지 않을 경우에 대한 대응
* 날짜 기간 필터를 선택했을 때 사용자가 인식할 수 있도록 UI 변경
* ✅ 플랫폼 옵션 설정 - API platforms Query
#### SearchView
* ✅ 키워드로 검색 - API search Query
* ✅ 검색 버튼을 누른 탭의 플랫폼 옵션과 정렬 방식을 유지한 상태로 검색
#### DetailView (+WebView)
* MainView로부터 정보 전달받기
* WebView로 예고편 재생
#### FavoritesView
* 탭바에 즐겨찾기 탭을 추가하고, 즐겨찾기한 게임들을 모아볼 수 있다.
* 즐겨찾기한 게임은 스와이프를 통해 즐겨찾기 해제가 가능하다.
#### SettingView
* 개발자에게 문의하기
* 리뷰 작성 안내
* 플랫폼/기간 옵션 기본값 변경 - UserDefaults
#### 추가 기능
* 하이퍼링크로 API 명시
* ✅ API와 통신중일 때 JGProgressHUD를 이용해 로딩중임을 사용자에게 명시
* 스와이프 제스쳐를 통해 뒤로가기/창 내리기 지원
#### 업데이트 (하고싶은...) 기능
* 스크린샷 등의 이미지는 굳이 고화질로 보여줄 필요 없을 것 같은데, 용량을 줄여보자!
* 장르 필터 추가 -> 필터가 여러개면 사용자가 헷갈리지 않도록 어떤식으로 알려줄지?
* DetailView에서 ActivityViewController를 통해 외부에 공유
-------------

### 개발 공수
| 회차 | 내용 | 세부내용 | 예상시간 | 특이사항 | 날짜 |
| --- | --- | --- | --- | --- | --- |
| **Iteration 1** |  |  |  |  | **~2022.09.11** |
|  |  | 다국어 지원 설계 | 2h | 2h |  |
|  |  | ColorSet/IconSet 구성 | 1h | 1h |  |
|  | NewGameView | Code Base 레이아웃 | 2h | 2h |  |
|  | NewGameView | 오픈API 통신 | 2h | 2h |  |
|  | UIMenu+Extension | UIMenu+Extension 구현 | 1h | 1h |  |
|  |  |  |  |  |  |
| **Iteration 2** |  |  |  |  | **~2022.09.14** |
| 13 | NewGameView | 플랫폼 필터 구현 | 3h | 2h 리펙토링 必 |  |
| 13 | NewGameView | 기간 필터 구현 | ~~3h~~ | 4h 리펙토링 必 |  |
| 13 | RatingGameView | 탭바 구현 | 1h | 1h |  |
| 13 | RatingGameView | NewGameView 기능 재구성 | ~~2h~~ | 1h |  |
| 13 | RatingGameView | 오픈 API 통신 | 1h | 1h |  |
| 14 | SearchView | 쿼리를 통한 검색 기능 구현 | ~~2h~~ | 1h |  |
| 14 | SearchView | 검색 결과에서 키워드 색상 변경 | ~~1h~~ | X 부적합 |  |
| 14 | 도전... | MVVM | ~~4h~~ | 실패... |  |
|  |  |  |  |  |  |
| **Iteration 3** |  |  |  |  | **~2022.09.18** |
| 15 | API 통신 | 페이지네이션 구성 | 1h | 1h |  |
| 15 | API 통신 | 페이지네이션 구현 | ~~6h~~ | 5h |  |
| 16 | UpcomingGameView | 출시예정작 뷰 추가 | 2h | 2h |  |
| 16 | 중간점검 | 버그해결 및 리펙토링 | 3h | 3h |  |
| 16 | SkeletonView | 로딩 구현 + 사용자 액션 제한 | ~~3h~~ | 2h HUD로 구현 |  |
| 17 | DetailView | Code Base 레이아웃 | 4h |  |  |
| 17 | DetailView | Struct Model 구성 | 1h |  |  |
|  |  |  |  |  |  |
| **Iteration 4** |  |  |  |  | **~2022.09.21** |
| 18 | DetailView | 선택된 셀의 정보 받아오기 | 3h |  |  |
| 18 | DetailView | 받아온 정보 뷰에 보여주기 | 1h |  |  |
| 19 | DetailView | bannerCollectionView 구성 | 2h |  |  |
| 19 | DetailView | 스크린샷 bannerCollectionView에 보여주기 | 3h |  |  |
| 20 | DetailView | bannerCollectionView 현재 페이지/전체 페이지 명시 | 2h |  |  |
| 20 | DetailView | bannerCollectionView 자동 스크롤 | 3h |  |  |
|  |  |  |  |  |  |
| **Iteration 5** |  |  |  |  | **~2022.09.25** |
| 21 | DetailView | WebView로 예고편 재생 | 3h |  |  |
| 22 | RealmModel | Realm 스키마 구성 | 1h |  |  |
| 22 | DetailView | 즐겨찾기 버튼 구현 (Realm 저장) | 3h |  |  |
| 23 | FavoritesView | Code Base 레이아웃 | 1h |  |  |
| 23 | FavoritesView | Realm 데이터 테이블뷰에 보여주기 | 2h |  |  |
| 24 | FavoritesView | 스와이프로 삭제 기능 구현 | 2h |  |  |
|  |  |  |  |  |  |
| **Iteration 6** |  |  |  |  | **~2022.09.28** |
| 25 | FavoritesView | didSeletRowAt | 3h |  |  |
| 26 | API 통신 | 네트워크 상태에 따른 대응 | 3h |  |  |
| 27 | 추가 기능 | SettingTableView 구현 | 3h |  |  |
| 28 | 추가 기능 | UserDefaults로 옵션 저장 | 2h |  |  |
|  | 추가 기능 | ActivityViewController | 2h |  |  |
|  | 추가 기능 | 오픈API 호출횟수 개선 | 3h |  |  |
|  |  |  |  |  |  |
| **Iteration 7** |  |  |  |  | **~2022.10.02** |
|  |  | 마무리 작업 | 5h |  |  |
|  |  | Code-Refactoring | 5h |  |  |
|  |  | 버그 찾기/수정 | 5h |  |  |
|  |  |  |  |  |  |
| **Iteration 8** |  |  |  |  | **~2022.10.05** |
|  |  | 출시 전 테스트 |  |  |  |
|  |  |  |  |  |  |
-------------
#### 09/13 
- 팀 회의 : 각자 기획한 프로젝트를 공유
- 일일 목적 : 공수산정 일일 세분화 | RatingGameView 구성 및 필터 구현   
- 플랫폼을 선택한 상태에서 날짜 변경, 날짜를 변경한 상태에서 플랫폼 변경 시 기존 선택옵션이 유지되도록 구현하는 것이 어려웠다.   
- Class에 변수를 두개 선언하고 옵션이 바뀔 때마다 저장했다가 불러오는 형태로 우선 구현했지만 더 좋은 방법이 있을 것 같다.

#### 09/14
- 팀 회의 : 일일 작업 목표 공유
- 일일 목적 : SearchView 검색 구현 | MVVM 도전  
- SearchView를 구현하는 것까지는 어렵지 않았고, 기존에 구현하려고 했던 검색 키워드 색상 변경은 API와 잘 맞지 않는것 같아 제외했다.   
- 해당 API는 검색 단어가 정확하지 않더라도 비슷한 이름의 게임을 찾아주기 때문에 항상 검색 단어가 포함되지는 않는다.   
- 기존에 구현한 VC를 ViewModel로 나누는 작업을 도전해봤으나 시간이 매우 오래 걸리고, 미숙하기 때문에 MVC로 구현하기로 했다.   
- 하지만 나중에라도 MVVM으로 전환하기 용이하도록 최대한 코드를 쪼개서 정리하는 것이 좋을 것 같다.

#### 09/15
- 기간 옵션을 변경했을 때, 현재 옵션이 적용되어 있다는 것을 보여주기 위해 해당 버튼의 컬러를 변경했다.
- 이 외에도 어떤 옵션을 선택했는지까지 보여주는 것이 좋을 것 같아, UIMenu 의 타이틀에 체크 표시를 보여주려고 한다.
- Prefetching으로 페이지네이션을 구현했으며, 플랫폼/기간 옵션 변경 시 뷰의 최상단으로 이동하는 코드를 추가했다.
- 거의 같은 구성의 화면을 사용하며, Cell의 정보만 다른 VC가 3개이기 때문에 DataSource, Delegate를 한번에 작성하는 것이 좋을 것 같다고 생각했다.
- 우선 구현 먼저 하자!! 라고 생각해서 여태까지 복붙으로 구현한 extension들을 한데 모아서 BaseCollectionViewController도 만들었다.
- BaseCollectionViewController도 BaseViewController를 상속받고 있기 때문에 관계가 조금 복잡해졌지만, 우선 분리 먼저 하고 리펙토링 할 예정이다.
- 팀원분들께 여쭤보니, 프로토콜을 만든 다음 extension 해서 메서드를 구현하면 더 깔끔하고, 메모리 측면에서도 좋다고 하니 이 방법을 사용해봐야겠다.

#### 09/16
- 출시예정 게임들을 모아서 보여주는 기능이 1.0부터 들어가면 좋을 것 같아서, 조금은 즉흥적으로 뷰를 추가했다.
- 오늘 날짜의 다음날부터 2099년까지 검색하기 위해 defaultEndDate 라는 전역 변수로 초기화한 후 APIManager에서 조건문을 통해 Query를 관리했다.
- 다크 모드에 대한 테스트를 아직 하지 않았어서, [colorhunt](https://colorhunt.co)를 참고해 ColorSet을 재구성했다.
- 전에는 시스템컬러를 사용했기 때문에 조건문을 통해 컬러를 지정해줬지만 Assets에 커스텀컬러를 만드니 코드가 간단해져서 좋은 것 같다.
- 로딩은 SkeletonView로 구현하고 싶었으나, CollectionView에 적용하는 방법이 조금 까다로워서 한시간 정도 애먹다가 그냥 JGProgressHUD로 구현했다. (나중에 업뎃하자...!)
- isUserInteractionEnabled를 통해 통신중 유저 이벤트를 제한하려고 했으나 테스트해본 결과, 별 다른 문제가 생기지 않아 일단 구현하지 않았다.
