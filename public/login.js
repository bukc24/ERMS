document.addEventListener('DOMContentLoaded', function() {
    login_form=document.querySelector('#loginForm');
    login_form.onsubmit = ()=>{ 
        login(new FormData(login_form));
        return false;
    }
    
});

async function login(data){
    const formData = new FormData(document.getElementById('loginForm'));
    console.log('hi')
    setTimeout(4000);


    await fetch('/login', {
        method:'POST',
        body: JSON.stringify({
            email: data.get('email'),
            password: data.get('password')
        }),
        headers: new Headers({'content-type': 'application/json'})
    })
    .then(response=>{
        
        if(!response.ok){
            throw new Error('Network response was not ok');
        }
        return response.json()
    })
    .then((result) => {
        console.log(result.jwt)
        client.setHeader("authorization", `Bearer ${result.jwt}`);

    })
    .catch(error=>{
        console.log(error)
    })
}
