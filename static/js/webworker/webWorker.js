let resType={
  responseType:null
}
let areFilter=[];
let tempArray=null;
let uidGroup=[];
let timeQuater={
  seson:0,
  currentWeekMonday:0
}
let computedArray=[];
onmessage=function(e){

  let action=e.data.action;

  let data=e.data.data || tempArray;
  tempArray=data;
if (e.data.seson) {
  timeQuater.seson=e.data.seson;
  timeQuater.currentWeekMonday=e.data.currentWeekMonday;
}

  switch (action) {
    case "total":
      sort(data['userInfo']);

      break;
    case "asc":
        let t1=data['userInfo'];
        t1.sort(function(a,b){
          return a.scores-b.scores;
        })

        resType={
          responseType:"total",
          data:t1
        }
      break;
    case "week":
    //先分组，再分段
    //一天的timechar=86400000
    //fork一份
    computedArray=[...tempArray['userInfo']];
//http://192.168.220.100/newsedit/e5workspace/doclist.do?DocLibID=2&FVID=184&FilterID=22,22,@@DATE%3D2018-07-05_1@@&ListPage=13&CurrentPage=1&CatTypeID=0&ExtType=0&RuleFormula=&keyword=&tabID=tab_edit_doc_all&CountOfPage=20&beginDate=&endDate=
//http://192.168.220.100/newsedit/e5workspace/doclist.do?DocLibID=2&FVID=186&FilterID=22,22,@@DATE%3D2018-07-05_1@@&ListPage=13&CurrentPage=1&CatTypeID=0&ExtType=0&RuleFormula=&keyword=&tabID=tab_edit_doc_all&CountOfPage=20&beginDate=&endDate=
//http://192.168.220.100/newsedit/e5workspace/doclist.do?DocLibID=4&FVID=189&FilterID=16,@@DATE%3D2018-07-05_1@@&ListPage=10&CurrentPage=1&CatTypeID=0&ExtType=0&RuleFormula=&keyword=&tabID=tab_newsedit_department&CountOfPage=20&beginDate=&endDate=
    let endTimeChar=parseInt((new Date().getTime())/1000);

   computedArray.map((v,k)=>{
      if (uidGroup[v.UID]) {
      computedArray[k]['scores']= uidGroup[v.UID].filter(v=>{
          console.log(formatDate(v.times))
          if (v.times>timeQuater.currentWeekMonday && v.times<endTimeChar) {
            console.log(12)
            return true;
          }else{
                console.log(21)
            return false
          }
        }).reduce((a,b)=>a+b)
      }
    })
    console.log(computedArray)
    sort(computedArray);
      break;
    default:

  }
    if (resType.responseType) {
      postMessage(resType);
      resType={
       responseType:null
     };
     //做好分组
        if (uidGroup.length==0) {
          tempArray.dati_record.map((v,k)=>{
            let tempHolderArray=new Array();
            tempHolderArray.push(v);
            uidGroup[v.uid]?uidGroup[v.uid].push(v):uidGroup[v.uid]=tempHolderArray;
          })
        }


    }

}

function sort(source){
  let t=source;
  t.sort(function(a,b){
    return b.scores-a.scores
  })
  t.map((v,k)=>{
    t[k]['rank']=k+1
    areFilter.push(JSON.stringify({text:v.workUnit,value:v.workUnit}))
  })
  areFilter=[...new Set(areFilter)]
  resType={
    responseType:"total",
    data:t,
    areFilter
  }
}


function formatDate(t) {

    now=new Date(t*1000);

　　var year = now.getFullYear(),
　　month = now.getMonth() + 1,
　　date = now.getDate(),
　　hour = now.getHours(),
　　minute = now.getMinutes(),
　　second = now.getSeconds();

　　return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
}
