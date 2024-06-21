

const express=require('express');
const app=express();

app.use('/post',express.urlencoded({extended:true}));

optiuni=[
	{
		nume:"alfabetic"
	},
	{
		nume:"lungime"
	}
]

app.get("/p4.html", function(req,res){

	res.sendFile(__dirname+ "/p4.html");
});


app.post("/post",function(req,res){

 let arr = [];
	console.log(req.body);
	for(let o of optiuni) {
		if(req.body.tip == 'alfabetic') {
			req.body.submit
		} else {

		}		
	}
	res.send(arr);
});

app.listen(3000, function(){console.log("Serverul a pornit");});


