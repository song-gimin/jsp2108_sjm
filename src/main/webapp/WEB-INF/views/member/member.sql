show tables;

create table member (
	idx        int  not null  auto_increment,   /* 고유번호 */
	mid        varchar(20)  not null,           /* 아이디(중복불허) */
	pwd        varchar(100)  not null,          /* 비밀번호(입력시 9자로 제한처리) */
	nickName   varchar(20) not null,						/* 별명(중복불허) */
	name       varchar(20)  not null,           /* 성명 */
	gender     varchar(10)	default '남자',      /* 성별 */
	birthday   datetime  default now(),         /* 생년월일 */
	tel        varchar(15),                     /* 연락처 */
	address		 varchar(50),							        /* 주소 */
	email      varchar(50)  not null,           /* 이메일(아이디,비밀번호 분실시 필요) */
	userInfor  char(6)  default '공개',          /* 회원정보 공개여부(공개,비공개 체크) */
	userDel    char(2)  default 'NO',           /* 회원탈퇴 신청여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
	point      int default 100,				        	/* 포인트(최초가입회원은 100, 한번 방문시마다 10 */
	level      int  default 4,                  /* 회원등급(1:VVIP, 2:VIP, 3:GOLD, 4:SILVER, 0:관리자) */
	visitCnt	 int default 0,										/* 방문횟수 */
	startDate  datetime default now(),					/* 최초 가입일 */
	lastDate   datetime default now(),					/* 마지막 접속일 */
	todayCnt   int default 0,										/* 오늘 방문한 횟수 */
	primary key(idx, mid)                       /* 기본key : 고유번호, 아이디 */ 
);

desc member;
drop table member;

select * from member;