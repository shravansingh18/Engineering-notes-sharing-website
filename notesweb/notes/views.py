from django.shortcuts import render,redirect
from django.contrib.auth.models import User
from .models import *
from django.contrib import auth
from datetime import date
from django.contrib.auth import  authenticate,login,logout
from .models import Notes
# Create your views here.
def index(request):
    return render(request, 'index.html')
def about(request):
    return render(request, 'about.html')
def contact(request):
    error = ""
    if request.method == "POST":
        f = request.POST['firstname']
        l = request.POST['lastname']
        c = request.POST['contact']
        d = request.POST['desc']
        e = request.POST['email']

        try:
            contact1.objects.create(phone=c, email=e,firstname=f,lastname=l,description=d)
            error = "no"


        except:
            error = "yes"
    dic = {'error': error}
    return render(request, 'contact.html' ,dic)
def userlogin(request):
    error=""
    if request.method =='POST':
        i=request.POST['email']
        h=request.POST['pwd']
        user=authenticate(username=i,password=h)
        try:
            if user:
                login(request,user)
                error="no"
                return redirect('/profile')
            else:error="yes"
        except:
            error="yes"
    d={'error':error}
    return render(request, 'login.html',d)

def signup1(request):
    error = ""
    if request.method == "POST":
        f = request.POST['firstname']
        l = request.POST['lastname']
        c = request.POST['department']
        g = request.POST['pwd']
        h = request.POST['password']
        i = request.POST['username']
        j = request.POST['contact_no']
        try:
            user = User.objects.create_user(username=i, password=h, first_name=f, last_name=l)
            signup.objects.create(user=user, contact=j, department=c)
            return redirect('userlogin')
            error = "no"

        except:
         error = "yes"
    dic = {'error': error}
    return render(request, 'signup1.html',dic)
def profile(request):
    if not request.user.is_authenticated:
        return redirect('login.html')
    user=User.objects.get(id=request.user.id)
    data=signup.objects.get(user=user)
    d={'data':data,'user':user}
    return render(request,'profile.html',d)
def logout1(request):
    logout(request)
    return redirect('userlogin')
def changepassword(request):
    if not request.user.is_authenticated:
        return redirect('login.html')
    if request.method=="POST":
        o=request.POST['old']
        n=request.POST['new']
        c=request.POST['confirm']
        if c==n:
            u=User.objects.get(username__exact=request.user.username)
            u.set_password(n)
            u.save()

    return render(request,'changepassword.html')
def editprofile(request):
    if not request.user.is_authenticated:
        return redirect('login.html')
    user=User.objects.get(id=request.user.id)
    data=signup.objects.get(user=user)
    error=False
    if request.method=='POST':
        f = request.POST['firstname']
        l = request.POST['lastname']
        c = request.POST['contact']
        user.first_name=f
        user.last_name=l
        data.contact=c
        user.save()
        data.save()
        error=True
        return redirect(profile)
    d={'data':data,'user':user,'error':error}
    return render(request, 'editprofile.html',d)
def uploadnotes(request):
    if not request.user.is_authenticated:
        return redirect('login')
    error = ""
    if request.method == "POST":
        b = request.POST['branch']
        s = request.POST['subject']
        n = request.FILES['notesfile']
        f = request.POST['filetype']
        d = request.POST['description']
        u=User.objects.filter(username=request.user.username).first()
        try:
             Notes.objects.create(user=u,uploadingdate=date.today(),branch=b,subject=s,notesfile=n,filetype=f,descriptiontype=d,status='pending')
             error = "no"

        except:
         error = "yes"
    d={'error':error}
    return render(request,'uploadnotes.html',d)
def viewmynotes(request):
    if not request.user.is_authenticated:
        return redirect('login')
    user=User.objects.get(id=request.user.id)
    notes=Notes.objects.filter(user=user)

    d={'notes':notes}
    return render(request, 'viewmynotes.html',d)

def deletemynotes(request,pid):
    if not request.user.is_authenticated:
        return redirect('login')
    notes=Notes.objects.get(id=pid)
    notes.delete()
    return redirect('viewmynotes')
def viewallnotes(request):
    if not request.user.is_authenticated:
        return redirect('login')
    notes=Notes.objects.all()

    d={'notes':notes}
    return render(request, 'viewallnotes.html',d)
def search(request):
    query=request.GET['query']
    allNotes=Notes.objects.filter(branch__icontains=query)
    params={'allNotes':allNotes}
    return render(request, 'search.html',params)