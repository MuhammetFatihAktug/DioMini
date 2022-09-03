# Dio Mini

Dio Mini have easy and simple components.
You can do primitive request and response operation like
get, post, put, delete, upload.
Also provide you change source code so you can change all code according to your preference.


## Getting Started Setup


### <span style="color: white"> ***Step-1***</span>

Now i will show you labels name and their means


*

        baseURL: your data base web adress. You will define, when you use DioMini class.
        example : https://SECRET.mockapi.io/

*

        mainUrl: endpoint of your data base adress. You will understand when you use the methods.
        example:https://SECRET.mockapi.io/users

*

        id: id is a descriptive for your data.
        example: https://SECRET.mockapi.io/users/name.json



## Understanding Methods

* <span style="color:green"> Firstly define object</span>
```dart
ModelClass _model = ModelClass(...); // define model class object
DioMini _helper = DioMini(
    model: _model,// or you can write like ModelClass(...)
    baseURL: 'Your base URL');
```

* <span style="color:green"> Use getData() method </span>
```dart
    final result =
        await _helper.getData('users', '4');
    print(result?['name']); // result is a map. I will convert list later.
```

* <span style="color:green"> Use getDataList() method </span>

```dart
    final result =
        await service.getDataList('users');
    print(result); // result is map list. Y will convert list later. :(
```

* <span style="color:green"> Use postData() method </span>

```dart
    await service.postData(model, 'newUsers')
        ? print('Correct')
        : print('NoCorrect');
```

* <span style="color:green"> Use putData() method </span>

```dart
    await service.putData(model, '5', 'users')
        ? print('Correct')
        : print('NoCorrect');
```

* <span style="color:green"> Use deleteData() method </span>
```dart
    await service.deleteData('5', 'users')
        ? print('Correct')
        : print('NoCorrect');
```
