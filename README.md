# GameDove  

### 앱 소개/특징
## 개발
- 최소 타겟 : iOS 14
- iPhone, Portrait 모드 지원
- 다국어 지원, 다크모드 지원, CustomFont
- MVC, UIKit, AutoLayout, Code Base UI
- SnapKit, Realm, Kingfisher, Toast, JGPProgressHUD, DeviceKit, SideMenu, Firebase Analytics/crashlytics
## 앱 소개
- App Store : https://apps.apple.com/kr/app/게임도브-신작-인기-게임-정보/id1645004525
![스크린샷 2022-12-30 오후 12 08 24](https://user-images.githubusercontent.com/92143918/210030490-c011cdc0-82c7-4aed-85c7-1276f0e655a6.png)
#### GamesView
- [Open API](https://rawg.io/apidocs) 통신을 통해 신작, 인기작, 출시예정작 게임을 플랫폼별로 열람할 수 있다.
- 검색도 가능하며 검색할 때에는 현재의 플랫폼과 정렬을 유지한다.
- 인기작의 경우 오래된 게임의 순위는 변동이 적기 때문에 날짜 필터를 통해 최신 정보를 확인할 수 있다.

#### DetailsView
- 셀을 선택하면 세부 화면으로 이동하며, 게임의 세부 정보를 볼 수 있다.
- 배너 컬렉션뷰를 통해 메인 이미지와 인게임 스크린샷을 볼 수 있으며, 자동 스크롤과 페이지 인덱스를 지원한다.
- 해당 화면에서 보관함 추가와 외부로 공유가 가능하다.

#### StorageView
- 보관함에 추가한 게임들은 여기서 모아볼 수 있으며, 아직 출시되지 않은 게임의 경우 날짜 색상을 다르게 보여준다.
- 보관중인 게임은 스와이프로 개별 삭제 또는 네비게이션 바 버튼으로 전체 삭제가 가능하다.

#### SettingsView
- 메인 플랫폼을 변경할 수 있으며, 앱을 실행했을 때 자동으로 메인 플랫폼을 먼저 보여준다.
- 문의 버튼을 통해 메일을 보낼 수 있다.
- 리뷰 작성 버튼을 통해 앱스토어 페이지로 이동할 수 있다.
- API 홈페이지로 바로 이동할 수 있다.
- 현재 버전을 체크해 보여준다.

## 주요 이슈
**출시 회고** : https://eun-dev.tistory.com/60

#### BannerCollectionView 이미지 미리 로드
- 배너가 스크롤되어 다음 이미지로 넘어갔을 때 이미지를 받아오기 시작하기 때문에, 사용자가 이미지를 넘길 때마다 로딩을 기다려야 한다는 문제가 있었다.
- 따라서 네트워크 통신과 동시에 url을 UIImage로 변환한 후 배열에 추가해, 한꺼번에 BannerCollectionView의 ImageView에 나타내기로 로직을 변경했다.
- 이렇게 하면 모든 url이 image로 변환된 후에 뷰를 보여주므로 셀마다 로딩이 필요하지는 않지만, DetailsView 자체의 로딩은 다소 길어진다는 문제가 있었다.

#### BannerCollectionView 이미지 비동기 로드
- 위의 업데이트로 디테일뷰의 로딩 시간이 길어졌기 때문에, 이 시간을 단축시키기 위해 여러 방법을 시도했다.
- 최종적으로 정한 방법은, 우선 네트워크 통신으로 이미지의 url을 받아왔을 때에는 바로 이미지로 변환하지 않고 배열에 담아둔 후 비동기로 이미지를 변환하는 것이다.
```
    var scList: [String] = []
    var imageList: [UIImage] = []
    
    private func fetchImage() {
        scList.forEach {
            guard let url = URL(string: $0) else { return }
            KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    let newImage = value.image.resize(newWidth: UIScreen.main.bounds.width)
                    self?.imageList.append(newImage)
                case .failure(_):
                    self?.view.makeToast(LocalizationKey.failedImage.localized)
                }
            }
        }
    }
```
- fetchImage에서는 반복문을 통해 비동기로 이미지를 변환하고, 이를 cellForRowAt에서 image로 설정한다.
- 단, 이미지가 미처 변환되지 못했을 때에는 크래쉬가 발생할 수 있으므로 imageList.count >= indexPath.row 라는 조건을 설정했다.
- https://user-images.githubusercontent.com/92143918/210030628-9e2313d5-ffe3-4574-a0c5-8d7ccb702d7f.mov
-------------
### 앱 UI/UX
![스크린샷 2022-08-30 오후 7 43 50](https://user-images.githubusercontent.com/92143918/187417082-522e3efd-3ff9-4796-bca8-8305659b5a8e.png)  
-------------
### 앱 기능
* ✅ 다국어 지원 (한영일)
#### NewGameView / RatingGameView / UpcomingGameView (TabBar)
* ✅ API 통신 ⭐️매우 중요⭐️ ---> 상태 코드나 연결 상태가 좋지 않을 경우에 대한 대응
* ✅ 플랫폼 옵션 설정 - API platforms Query
#### SearchView
* ✅ 키워드로 검색 - API search Query
* ✅ 검색 버튼을 누른 탭의 플랫폼 옵션과 정렬 방식을 유지한 상태로 검색
#### DetailView (+WebView)
* ✅ MainView로부터 id를 전달받아 API로부터 상세정보 받아오기
* ✅ DetailView에서 ActivityViewController를 통해 외부에 공유
* ✅ 배너 컬렉션뷰 구현 - 자동 스크롤, 페이지 인덱스
#### StorageView
* ✅ 탭바에 보관함 탭을 추가하고, 보관함에 추가한 한 게임들을 모아볼 수 있다.
* ✅ 보관중인 게임은 스와이프를 통해 삭제가 가능하다.
#### SettingView
* ✅ 메인 플랫폼 설정
* ✅ 개발자에게 문의하기
* ✅ 리뷰 작성하기
* ✅ API 백링크
* ✅ 버전 체크
#### 업데이트
* ✅ API와 통신중일 때 JGProgressHUD를 이용해 로딩중임을 사용자에게 명시
* ✅ 스크린샷 등의 이미지는 굳이 고화질로 보여줄 필요 없을 것 같은데, 용량을 줄여보자!
* ✅ 출시예정작을 보관함에 추가할 경우 releasedLabel 색 바꾸기
* ✅ 검색 화면에서 search 버튼을 눌렀을 때 키보드가 내려가도록 개선
* ✅ 플랫폼 변경 버튼이 아닌, 네비게이션 바 타이틀을 터치했을 때 플랫폼을 변경할 수 있도록 개선
* ✅ 보관중인 게임 전체 삭제 버튼 추가
* ✅ 배너 컬렉션뷰가 넘어가기 전 미리 kf로 이미지를 받아올 수 있도록 개선
* ✅ 사용자가 배너 컬렉션뷰를 직접 스크롤 했을 경우 타이머를 초기화하도록 개선
* ✅ 메타스코어 순으로 정렬된 뷰 추가
#### 업데이트 예정
* navigation bar button 간격 줄이기
* 출시예정작을 보관함에 추가할 경우 출시일에 노티 띄우기
* 각 플랫폼별 1~10위 순위 게임 모아보기
#### 그 외
* 메인 뷰에서 셀의 이미지가 한박자 늦게 바뀌거나 중복되는 에러
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
| 13 | NewGameView | 플랫폼 필터 구현 | 3h | 2h |  |
| 13 | NewGameView | 기간 필터 구현 | ~~3h~~ | 4h |  |
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
| 17 | DetailView | Code Base 레이아웃 | 4h | 4h |  |
| 17 | DetailView | Struct Model 구성 | 1h | 1h |  |
|  |  |  |  |  |  |
| **Iteration 4** |  |  |  |  | **~2022.09.21** |
| 18 | DetailView | 선택된 셀의 정보 받아오기 | 3h | 3h |  |
| 18 | DetailView | bannerCollectionView 구성 | 2h | 2h |  |
| 18 | DetailView | 스크린샷 bannerCollectionView에 보여주기 | 3h | 3h |  |
| 18 | DetailView | bannerCollectionView 현재 페이지/전체 페이지 명시 | 2h | 2h |  |
| 18 | DetailView | bannerCollectionView 자동 스크롤 | ~~3h~~ | 2h |  |
| 19 | DetailView | WebView로 예고편 재생 | 3h | X API 데이터 부족 |  |
| 19 | DetailView | 받아온 정보 뷰에 보여주기 | ~~1h~~ | 2h |  |
| 19 | DetailView | UI 수정 | 4h | 4h |  |
| 20 | RealmModel | Realm 스키마 구성 | ~~1h~~ | 3h |  |
| 20 | SettingView | 메인 플랫폼 저장 구현 | ~~3h~~ | 1h |  |
|  |  |  |  |  |  |
| **Iteration 5** |  |  |  |  | **~2022.09.25** |
| 21 | DetailView | 보관 버튼 구현 (Realm 저장) | ~~3h~~ | 1h |  |
| 21 | StorageView | Code Base 레이아웃 | 1h | 1h |  |
| 21 | StorageView | Realm 데이터 테이블뷰에 보여주기 | ~~1h~~ | 30h |  |
| 21 | StorageView | 스와이프로 삭제 기능 구현 | ~~1h~~ | 30h |  |
| 21 | StorageView | didSeletRowAt | ~~1h~~ | 30h |  |
| 22 | 추가 기능 | ActivityViewController | ~~2h~~ | 1h |  |
| 25 | API 통신 | 네트워크 상태에 따른 대응 | ~~4h~~ | 2h |  |
|  |  |  |  |  |  |
| **Iteration 6** |  |  |  |  | **~2022.09.28** |
|  | 기능 개선 | DetailsCollectionViewCell 동적 구현 | ~~3h~~ | 2h |  |
|  | 기능 개선 | 기간 메뉴 선택 명시 | 2h | 2h |  |
|  | 추가 기능 | SettingTableView 구현 | ~~3h~~ | 5h |  |
|  | 추가 기능 | 보관함 출시예정작 컬러 변경 | ~~2h~~ | 1h |  |
|  | 업데이트 | Realm 10.30.0 업뎃 | ~~30m~~ | 10m |  |
|  | 추가 기능 | 새로고침 버튼 구현 | 1h | 1h |  |
|  | 기능 개선 | 폰트 변경 | ~~1h~~ | 2h |  |
|  |  |  |  |  |  |
| **Iteration 7** |  |  |  |  | **~2022.10.02** |
| 29 | 1.0 | 앱스토어 심사 제출 | 1h | 1h |  |
| 01 | 1.0 | 리젝... 그리고 수정 | 1h | 1h |  |
| 02 | 1.1 | SideMenu를 통한 탭바 나누기 | 1h | 1h |  |
| 02 | 1.1 | NavigationTitle Button 구현 | 1h | 1h |  |
|  |  |  |  |  |  |
| **Iteration 8** |  |  |  |  | **~2022.10.05** |
| 03 | 1.1.1 | 보관중인 게임 전체삭제 버튼 추가 | 1h | 1h |  |
| 03 | 1.1.1 | 자잘한 오류 수정 | 1h | 1h |  |
| 04 | 1.1.1 | 배너 자동스크롤 타이머 초기화 | 1h | 1h |  |
| 04 | 1.1.1 | 배너 이미지 로딩시간 개선 | 2h | 2h |  |
| 05 | 1.1.2 | 배너 이미지 변환 비동기 구현 | 2h | 2h |  |
| 05 | 1.1.2 | 배너 이미지 중복 사진 제거 | 1h | 1h |  |
| 05 | 1.1.2 | Firebase 설정 | 1h | 1h |  |
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

#### 09/17
- DetailView와 모델을 구성하고, API를 통해 상세 데이터를 받아오는 작업을 했다.
- 여태까지는 self.navigationController?.navigationBar.topItem?.title = ""를 통해 백버튼의 타이틀을 지워왔어서 이번에도 동일하게 적용하니, GamesView로 pop했을 때 title이 지워진 상태로 보이는 현상이 있었다.
- navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) 로 수동 설정해서 해결했다.
- 주의!! GamesView로 돌아오는 백버튼의 타이틀을 바꾸는 것이기 때문에 GamesViewController에서 바꿔야 한다.
- 게임의 상세정보를 받아오는 API 주소에서 뒷부분에 /screenshots 만 추가하면 스크린샷을 받아올 수 있기 때문에, DetailsAPIManager 메서드를 호출할 때 매개변수로 sc 라는 이름의 Bool 타입을 받아온 후 분기처리를 통해 적합한 데이터를 반환할 수 있도록 구성했다.
- 상세정보와 스크린샷, API를 두 번 호출해야 하기 때문에 DispatchGroup enter/loave 를 통해 모든 통신이 종료된 후 reload 를 실행했다.
- 타이머를 활용해 3초마다 자동으로 배너가 스크롤되는 기능을 구현했는데, 사용자가 직접 스크롤 할 경우 타이머 초기화와 무한 스크롤 등의 기능을 추가하면 좋을 것 같다.
- 뷰를 스크롤뷰로 구성할 예정이기 때문에 자동스크롤에 필요한 메서드인 scrollViewDidEndDecelerating의 매개변수 타입을 UICollectionView로 바꿨는데, 바꾸지 않을 경우 실제로 문제가 발생하는지에 대해서는 나중에 따로 테스트 해보려고 한다 --> CollectionView 혹은 TableView로 구성할 것으로 계획이 변경되었기 때문에 이제는 의미가 없다!

#### 09/18
- SettingsViewController를 구성하고, 각 셀을 선택했을 때의 기능을 구현했다.
- 문의하기 버튼을 누르면 오픈소스 DeviceKit 를 이용해 현재 OS 버전과 디바이스 이름, 사용중인 App 버전을 Body로 받아온다.
- 리뷰 작성 버튼을 누르면 앱스토어 링크를 통해 리뷰 화면으로 바로 이동한다. (app id는 app store connet에서 확인 가능하다.)
- 현재 버전을 체크해서 옵션창에서 보여줄 수 있고, api의 백링크도 설정창에 추가했다.
- 메인 플랫폼을 설정할 수 있는 얼럿 시트를 구현할 예정이었으나, 플랫폼의 타입이 enum이기 때문에 UserDefaults로는 구현이 불가해서 추후 Realm을 사용해 구현할 계획이다.
- bannerCollectionView에 page index를 구현하는 것 까지는 성공했으나 직접 스크롤할 경우 index가 변하지 않는다.
- 다만 배너는 출시에 중요한 부분은 아니고, 자동 스크롤을 지원하지 않으면 인덱스가 꼬일 일도 없기 때문에 우선순위가 낮아 나중에 해결하기로 했다. --> 해결 완료!
- 디테일뷰에서 레이아웃 관련 로그가 정말... 정말 많이 뜬다. 하나씩 지우면서 테스트해봐도 어디서 문제가 발생하는지 잘 모르겠다.ㅠㅠ

#### 09/19
- 배너의 인덱스가 꼬이는 이유를 찾아냈다! 17일에 작성한 마지막 항목이 문제였다.
- 매개변수 타입을 바꿔서 사용했기 때문에 더 이상 scrollView의 메서드가 아니게 되어버린, 그냥 private 함수가 되어버렸던 것이다ㅜㅜ
- 사실 해당 함수에 대해 이해가 잘 되지 않고 있었는데, 팀 회의를 하며 팀원분 의견을 듣고 떠올리게 되었다. (감사합니다!!)
- 또 잘못 생각했던게 nowPage에 관한 코드는 스크롤뷰의 width와 x 길이를 가지고 판단하는 것이기 때문에 두 스크롤뷰의 방향이 다르다면 걱정 할 필요 없었던 것 같다.
- 만약 스크롤뷰의 방향이 같다면, 스크롤뷰 (컬렉션/테이블) 의 이름으로 조건을 걸거나 가드문으로 타입 캐스팅을 해주면 될 것 같다!
- 레이아웃 디버그 로그가 너무 많이 뜨는데… Rleam 설치해서 빌드 속도 느려지기 전에 고쳐야한다고 생각해서 열심히 서치해봤다.
- https://www.wtfautolayout.com/ 에 로그를 복붙하면 직관적으로 알려주긴 하지만, 변수명까지 나오지는 않기 때문에 어렵다…
- 위의 해석본(?)을 봐도 모르겠어서, 뷰 계층을 확인해보니 왼쪽이나 윗쪽에 보라색 표시로 문제가 있는 객체에 대해 알려준다.
- 그리고 로그의 이상한 숫자와 영어의 조합이 있을텐데, 이것을 오른쪽의 Address를 비교해보면 문제를 알 수 있다.
- 하지만… 아직도… 못고쳤다…!

#### 09/20
- 이미지의 크기가 너무 큰 것 같아 용량을 줄이기 위해 extension UIImage에 resize 메서드를 구현했다.
- Kingfisher를 사용할 땐 간편한 kf.setImage 메서드를 사용했지만 이번에는 바로 이미지를 설정하는 것이 아니기 때문에, retrieveImage 메서드를 사용했다.
- 성공/실패 시의 코드를 switch로 구분하고, 성공 시 반환값의 image를 리사이징 한 다음 cell의 bannerImageView에 넣어주었다.
- 로그를 보면 1/4 수준으로 줄어들었다! …하지만 기대와 다르게 로딩 시간에는 별반 차이가 없는 듯 하다.
- 용량을 줄였다고는 해도 url로 서버에서 이미지를 받아오는 작업을 셀이 보일 때 시작하기 때문인 것 같다.
- url을 이미지로 변환하는 작업을 끝내고 나서 화면을 보여주거나, 비동기로 이미지만 변환하는 작업을 실행하는 방법이 있을 것 같긴 한데…
- enum의 원시값을 통해 enum case로 역으로 접근할 수 있다는 사실을 이제 알았다…!
#### 09/21
- 컬렉션뷰의 높이를 컨텐츠의 양에 따라 동적으로 구성하고 싶었는데, 생각처럼 되지 않아서 고생중이었다.
- 팀 회의때 질문하니 여러 방법들을 알려주셔서 거의 한시간동안 이것저것 시도해보고, 결국 해결할 수 있었다.
- 바쁘신 와중에도 도와주신 우리 팀원분들에게 무한감사!!!
- layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
- cell.contentView.widthAnchor.constraint(equalToConstant: mainView.width).isActive = true
- 해결에 핵심이 된 것은 위의 두 줄의 코드로, 방법 자체는 간단했다.
- 테이블뷰와 같이 너비가 고정된 형태의 컬렉션뷰에서 높이만 동적으로 표현하고 싶었기 때문에, 오토메틱 사이즈로 설정한 후 셀의 widthAnchor만 고정시켜 두면 높이는 오토레이아웃 제약조건에 의해 알아서 동적으로 설정되도록 할 수 있다.
- 게임 보관함의 모델은 game의 id를 pk로 구성하여, 보관함 버튼을 눌렀을 때 repository에 구현해둔 메서드를 통해 중복 체크를 한 후 분기처리를 했다.

#### 09/22
- 이미 출시한 게임들은 출시일이 큰 의미가 없지만, 출시예정작은 날짜가 중요할 것 같아 보관함에서 출시예정인 게임들의 releaseLabel만 컬러를 다르게 적용했다.
- ActivityViewController를 활용해 타이틀과 출시일, 그리고 대표이미지를 외부에 공유할 수 있다.

#### 09/26
- DetailsView만 진입하면 레이아웃 로그가 엄청나게 많이 뜨는 것이 영 거슬리고 불안해서, 테스트 프로젝트를 만들어, 코드로 구성한 UI를 전부 스토리보드로 재현해봤다.
- 스토리보드로 확인해보니, Cell 내의 두 레이블이 각각 크기를 갖지 않고 여백으로 관계를 구성하는데 우선 순위가 설정되어 있지 않는 문제가 있었다.
- 따라서 setContentHuggingPriority 메서드를 통해 우선순위를 설정하니 디버그 영역의 보라색 에러는 사라졌다.
- 하지만 그래도 로그는 계속 떠서 잭님께 여쭤봤더니, 꼭 문제가 되지 않더라도 greaterthan 같은 걸 쓰게 권장하는 디버깅 문구가 뜰 수도 있다고 하셨다.
- 이럴 땐 여러 해상도의 디바이스로 테스트 해 보고, 비정상적인 부분이 없다면 무시해도 괜찮을 것이라고 하셨다!!!! (다행...^~^)

#### 09/27
- PeriodMenu를 선택했을 때 선택한 기간에 대해 체크 이미지로 명시하는 기능 구현 완료!
- UIAction의 핸들러에 resetMenu라는 메서드를 추가하고, 핸들러에서 실행시켜 이미지를 다시 그리도록 해서 구현했다.
- 정말 간헐적으로 메인 화면의 게임 이미지가 중복해서 뜨는 오류가 발생한다.
- 연속해서 뜨는 것과, 실행할 때마다 달라지는 것을 보면 재사용 셀에 관한 오류는 아닌 것 같아 kf의 로딩 순서에 문제가 있는지 의심중이다.

#### 09/28
- 팀원 분들과 서로 TestFlight에 초대하고, 어플을 테스트하는 시간을 가졌다.
- 여태 개발하면서 찾지 못했던 에러를 금방 발견해주셨는데, 셀이 0개인 상태에서 다른 옵션을 선택하면 앱이 충돌하는 문제였다.
- 이는 기간을 변경할 경우 컬렉션뷰의 최상단으로 올라가는 시점이 셀의 리로드 시점보다 더 빨라서 발생하는 오류로, self?.scrollToTop()를 더 뒤에 실행하도록 순서를 바꾸니 해결되었다.
- 통신에 실패했을 때 혹은 셀에서 버그가 발생했을 때 사용자 스스로 대처할 수 있도록 새로고침 버튼을 추가했다.
- 커스텀 폰트를 적용시켰는데, 이쁘고 다국어지원하고 가독성좋은 폰트를 찾느라 꽤 걸렸는데, 막상 바꾸고나니 기본 시스템폰트와 큰 차이가 없는 것 같기도 하다...

#### 09/29
- 검색 화면에서 아무것도 검색하지 않은 상태로 새로고침 버튼을 누를 경우, 검색어 쿼리가 “” 이기 때문에 모든 게임이 로드되는 문제가 발견됐다.
- 따라서 SearchViewController의 viewDidLoad에서 쿼리를 “검색” 으로 입력해서 아무 결과도 나오지 않게 변경했다.

#### 10/01 : 1.0 출시
- 리젝…당했다…ㅠㅠ 리젝에 관한 내용은 블로그에 작성할 예정이다.
- 리젝 당한김에 수정하고 싶었던 부분을 수정했다.
- 검색 화면에서 search버튼을 누를 시 키보드가 내려가도록 개선했다.
- 팀원분이 알려주신 CollectionViews willDisplay 메서드를 이용해, 배너 컬렉션뷰의 다음 이미지를 미리 로드하도록 개선했다.

#### 10/02 : 1.1 업데이트
- 플랫폼 변경이 자연스럽도록 NavigationItem.titleView를 UIButton으로 구현하였다.
- 탭바의 갯수가 다소 많다고 느껴졌기 때문에, SideMenu 라이브러리를 활용해 탭바를 쪼개는 작업을 했다.

#### 10/03
- Storage에 보관중인 게임을 전체 삭제하는 버튼을 만들었다.
- 처음에는 realm의 removeAll() 메서드를 통해 구현했었지만, 이렇게 하면 realm의 모든 모델(Settings) 이 전부 삭제되기 때문에 objects(Storage.self)로 한번 걸러낸 후 삭제하는 방식으로 변경했다.
- 1.1 업데이트에서 기본 메인플랫폼을 iOS로 변경했으나, 설정 탭에서는 기존의 Switch로 적용되어 있는 오류를 수정했다.
- bannerCollectionView의 이미지 로딩 시간을 개선하기 위해 willDisplay, prefetch 등의 메서드를 활용해 봤지만 적절한 방법은 아닌 것 같다.

#### 10/04 : 1.1.1 업데이트
- 네트워크 통신과 동시에 url을 UIImage로 변한 후 배열에 추가해, 이를 한꺼번에 bannerCollectionView의 imageView에 나타내기로 로직을 변경했다.
- 이렇게 하면 모든 url image로 변환된 후에 뷰를 보여주므로 셀마다 로딩이 필요하지는 않지만, DetailsView 자체의 로딩은 다소 길어질 수 있을 것 같다.
- 아무리 비동기로 진행한다고 해도, 가장 용량이 큰 이미지가 4초가 걸린다고 가정하면 이 한장의 이미지 때문에 4초를 꼬박 기다려야 하기 때문이다.
- 하지만 모든 url의 변경이 완료되기 전에 뷰를 띄워버리면 크래쉬가 발생하기 때문에 이 부분에 대해서는 더 고민해봐야 할 것 같다.
- 기존 코드로는 사용자가 직접 스크롤했을 경우에도 멈추지 않고 타이머대로 자동 스크롤이 동작하기 때문에, 의도치 않게 빠르게 넘어가는 상황이 발생할 수 있다.
- 따라서 class 내 전역변수로 옵셔널 Timer 타입의 timer를 선언해놓고, bannerTimer() 메서드에서 timer를 초기화하도록 코드를 수정했다.
- 그리고 scrollViewDidEndDecelerating를 통해 사용자가 직접 스크롤했을 경우 timer?.invalidate() 로 타이머를 정지시킨 후 다시 bannerTimer()를 호출해 재개하도록 구현했다.

#### 10/05 : 1.1.2 업데이트
- 1.1.1 업데이트로 디테일뷰의 로딩 시간이 길어졌기 때문에, 이 시간을 단축시키기 위해 여러 방법을 시도했다.
- 성공한 방법은, 우선 네트워크 통신으로 이미지의 url을 받아왔을 때에는 바로 이미지로 변환하지 않고 배열에 담아둔다.
- 그리고 이미지를 변환시키는 함수를 fetchImage 라는 이름으로 만들어, 네트워크 통신이 완료되었을 때 호출한다.
- fetchImage에서는 반복문을 통해 비동기로 이미지를 변환하고, 이를 cellForRowAt에서 image로 설정한다.
- 단, 이미지가 미처 변환되지 못했을 때에는 크래쉬가 발생할 수 있으므로 imageList.count >= indexPath.row 라는 조건을 설정한다.
- 메인이미지와 스크린샷 이미지가 중복되는 경우가 많기 때문에 네트워크 통신이 끝났을 때 scList.removeAll(where: { $0 == mainImage }) 를 통해 중복된 url을 제거하는 코드를 추가했다.
- Firebase를 다운받아 설정하고, Analytics와 Crashlytics로 정보를 받아오도록 했으며, 플랫폼을 바꿀 때의 이벤트 로깅을 추가했다.

#### 10/15 : 1.1.3 업데이트
- 게임 리스트 탭에서 바로 메타스코어를 확인할 수 있도록 UI를 수정했다.
- MetascoreGameViewController를 추가해서 현재 Rating 뿐만 아니라 메타스코어 순으로 게임을 확인할 수 있도록 개선했다.

#### 10/16 : 1.1.4 업데이트
- hidesBottomBarWhenPushed = true 를 통해 사이드메뉴를 통한 푸시 시 탭바를 숨기도록 수정했다.
- 메타스코어 레이블의 색상과 크기를 더 자연스럽게 수정했다.
