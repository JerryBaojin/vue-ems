let resType={
  responseType:null
}
let areFilter=[];
let tempArray=null;
onmessage=function(e){

  let action=e.data.action;
  let data=e.data.data || tempArray;
  tempArray=data;

  switch (action) {
    case "total":
    //desc
      let t=data['userInfo'];
      t.sort(function(a,b){
      	return b.scores-a.scores
      })
      //加入排名

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
    default:

  }
    if (resType.responseType) {
      postMessage(resType);
      resType={
       responseType:null
     };
    }

}
