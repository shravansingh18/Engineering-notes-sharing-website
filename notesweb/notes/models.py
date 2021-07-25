from django.db import models
from django.contrib.auth.models import User


# Create your models here.
class signup(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    contact = models.CharField(max_length=30, null=True)
    department = models.CharField(max_length=30,null=True)
    def __str__(self):
        return self.user

class Notes(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    uploadingdate = models.DateField(max_length=30,null=True)
    branch = models.CharField(max_length=30,null=True)
    subject = models.CharField(max_length=30,null=True)
    notesfile = models.FileField(max_length=30,null=True)
    filetype = models.CharField(max_length=30,null=True)
    descriptiontype = models.CharField(max_length=300,null=True)
    status = models.CharField(max_length=30)
    def __str__(self):
        return self.user
class contact1(models.Model):

    firstname = models.CharField(max_length=30, null=True)
    lastname = models.CharField(max_length=30, null=True)
    email = models.CharField(max_length=30, null=True)
    description = models.CharField(max_length=300, null=True)
    phone = models.CharField(max_length=30, null=True)

    def __str__(self):
        return self.firstname