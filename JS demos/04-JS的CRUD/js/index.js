//write
//document.write('hello world');
//写入的是body的路径
//document.write('<img src="image/img_03.jpg">');
//document.write('<input>');
//document.write('<input type="date">');
//
////2.写入一个button
//var btn = document.createElement('button');
////设置样式
//btn.innerHTML = '这是一个按钮';
//btn.style.border = '1px solid #ddd';
//btn.style.width = '100';
//btn.style.height = '40';
//btn.style.background = 'red';
////写进去
////document.body.appendChild(btn);
//
////console.log(btn);
//
////按钮加进去div里面 一次只能添加一个按钮
//var div = document.getElementsByClassName('test')[0];
//div.appendChild(btn);
//
////删除
////1.
//var img = document.getElementsByClassName('icon')[0];
////document.body.removeChild(img);
////推荐做法
////img.parentNode.removeChild(img);
////
////btn.parentNode.removeChild(btn);
//
////2
////img.remove();
////btn.remove();
//
////修改
//btn.innerHTML = '我不是按钮';
//btn.style.border = 'solid';
//btn.style.backgroundColor = 'blue';
//btn.style.color = 'white';
//
//
////修改链接
//var a = document.getElementsByClassName('netease')[0];
////console.log(a);
//a.href = 'http://t.tt';
//a.target = '_blank';

//console.log(document.body.children);


//查询
//function find(o){
//
//    for(var i=0;i< o.length;i++){
//        console.log(o[i]);
//    }
//
//}
//
////find(document.body.children);
//
//var divs = document.getElementsByClassName('test');
//find(divs);

//console.log(document.body.innerHTML);
console.log(document.body.outerHTML);