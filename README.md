# Dio Mini

Dio Mini have easy and simple components.
You can do primitive request and response operation like
get, post, put, delete, upload.
Also provide you change source code so you can change all code according to your preference.


## Getting Started Setup

### <span style="color: white"> ***Step-1***</span>

When you using helper ,Be careful.
Firstly you should define your model class typdef in the IDioMini class.

```dart
// !!! you must change StudentModel your ModelClass
typedef ModelClass = ' Your Model Class ' ; // !!!
// !!!
```
(You will got to source code fastly with pressed ctrl and click package name :) )



### <span style="color: white"> ***Step-2***</span>

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


## Example

!  <span style="color:red"> Don't go here without doing the first step</span>

* <span style="color:green"> Firstly define object</span>
```dart
DioMini _helper = DioMini(baseURL: 'Your base URL');
```

* <span style="color:green"> Use getData() method </span>
```dart
    final result =
        await _helper.getData('users', '4');
    print(result?.name);
```

* <span style="color:green"> Use getDataList() method </span>

```dart
    final result =
        await service.getDataList('users');
    print(result?[0].name);
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
