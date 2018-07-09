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

onmessage=function(e){

  let action=e.data.action;
  if (e.data.data) {
      var data=e.data.data;
      tempArray={...data};
  }else{
      data={...tempArray};
  }


  switch (action) {
    case "total":
      var computedArrayC=data['userInfo'];
      sort(computedArrayC);
      if (uidGroup.length==0) {
        tempArray.dati_record.map((v,k)=>{
          let tempHolderArray=new Array();
          tempHolderArray.push(v);
          uidGroup[v.uid]?uidGroup[v.uid].push(v):uidGroup[v.uid]=tempHolderArray;
        })
      }
    /*

    computedArrayC.map((v1,k)=>{
       if (uidGroup[v1.UID]) {
         let sortEd= uidGroup[v1.UID];
         let newSocres=0;
         sortEd.map(v=>{
           newSocres+=parseInt(v.scores);
         })

             computedArrayC[k]['scores']=newSocres;
       }
     })
  sort(computedArrayC);
  */
      break;

    case "sortDiff":
    var t={...data}
    computedArrayC=t['userInfo'];
        let startAt=tempArray.currentWeekMonday;

        const year=new Date().getFullYear();
        const month=new Date().getMonth()+1;
            switch (e.data.type) {
              case "week":
                startAt=tempArray.currentWeekMonday;
                break;
                case "month":
                    let start_Day=`${year}-${month}`
                    startAt=parseInt(new Date(start_Day).getTime()/1000);
                  break;

              case "quarter":
              //一个季度3个月
                const currentQuarter=Math.ceil(month/3)-1;
                let start_Month=`${year}-${currentQuarter*3}`
                startAt=parseInt(new Date(start_Month).getTime()/1000);
                break;
              case "year":
                startAt=parseInt(new Date(`${year}-1-1`).getTime()/1000);
                break;
              default:

            }


    let endTimeChar=parseInt((new Date().getTime())/1000);
        startAt=parseInt(startAt);

   computedArrayC.map((v1,k)=>{
      if (uidGroup[v1.UID]) {

      var  sortEd= uidGroup[v1.UID].filter(v=>{

          if (v.times>startAt && v.times<endTimeChar) {

            return true;
          }else{
            return false
          }
        })
        let newSocres=0;
        sortEd.map(v=>{
          newSocres+=parseInt(v.scores);
        })
            computedArrayC[k]['scores']=newSocres;
      }
    })

    sort(computedArrayC);
      break;
    default:

  }
    if (resType.responseType) {
      postMessage(resType);
      resType={
       responseType:null
     };
     //做好分组



    }

}

function sort(source){
  let t=[...source];
  t.sort(function(a,b){
    return b.scores-a.scores;
  })
  t.map((v,k)=>{
    t[k]['rank']=k+1
    areFilter.push(JSON.stringify({text:v.workUnit,value:v.workUnit}))
  })
  areFilter=[...new Set(areFilter)];

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
