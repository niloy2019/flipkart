
//Function to Display Login Form
function openLogin(){
	document.getElementById("signup").style.display = "none";
	document.getElementById("login").style.display = "flex";
	document.getElementById("b").style.filter="blur(1px)";
	document.getElementById("navbar").style.backgroundColor="rgb(239,241,244)";
}


//Function to close Login Form
function closeLogin(){
	document.getElementById("login").style.display = "none";
	document.getElementById("b").style.filter="blur(0px)";
	document.getElementById("navbar").style.backgroundColor="white";
}



//Function to Display Signup Form
function openSignup(){
	document.getElementById("login").style.display = "none";
	document.getElementById("signup").style.display = "flex";
	document.getElementById("b").style.filter="blur(1px)";
	document.getElementById("navbar").style.backgroundColor="rgb(239,241,244)";
}


//Function to close Signup Form
function closeSignup(){
	document.getElementById("signup").style.display = "none";
	document.getElementById("b").style.filter="blur(0px)";
	document.getElementById("navbar").style.backgroundColor="white";
}


