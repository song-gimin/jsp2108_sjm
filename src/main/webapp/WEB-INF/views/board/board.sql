show tables;

create table board (
	idx      int  not null auto_increment,
	mid      varchar(20)  not null,
	title    varchar(100)  not null,
	email    varchar(50),
	content  text  not null,
	wDate    datetime  default now(),
	readNum  int  default 0,
	hostIp   varchar(50)  not null,
	good     int  default 0,
	primary key(idx)
);

desc board;

insert into board values (default,'admin','Q&A를 등록하세요.','admin1234@naver.com','게시판을 만들어볼까나 후후',default,default,'111.111.111.111',default);

select * from board order by idx desc;


/* 댓글....처리.... */
create table boardReply (
  idx				 int not null auto_increment primary key,
  boardIdx	 int not null,	
  mid				 varchar(20) not null,	
  wDate			 datetime		default now(),
  hostIp		 varchar(50) not null,	
  content		 text				not null,
  level      int not null default 0,    /* 댓글레벨 : 부모댓글의 레벨은 '0' */
 	levelOrder int not null default 0,    /* 댓글의 순서 : 부모댓글의 levelOrder은 '0' */
  foreign key(boardIdx) references board(idx) 
  on update cascade 
  on delete restrict
);

desc boardReply;

select * from boardReply order by idx desc;