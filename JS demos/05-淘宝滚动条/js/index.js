//类型比较

function $(id){
    return typeof id === 'string' ? document.getElementById(id):id;
}

window.onload = function(){
    //拿到所有的li标签
        var titles = $('tab-header').getElementsByTagName('li');
    //console.log(titles.length);
    var divs = $('tab-content').getElementsByTagName('div');

    //判断
    if(titles.length != divs.length)return;

    for(var i = 0;i<titles.length;i++){
        var li = titles[i];
        li.id = i;

        li.onmousemove = function(){

            //先遍历，清除选中
            for(var j=0;j<titles.length;j++){
                titles[j].className = '';
                divs[j].style.display = 'none';
            }

            //再单独加进去select
            this.className = 'select';
            divs[this.id].style.display = 'block';
        }
    }
}