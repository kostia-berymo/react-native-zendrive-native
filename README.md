# react-native-zendrive-native

## Getting started

`$ npm install react-native-zendrive-native --save`

### Mostly automatic installation

`$ react-native link react-native-zendrive-native`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-zendrive-native` and add `ZendriveNative.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libZendriveNative.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.ZendriveNativePackage;` to the imports at the top of the file
  - Add `new ZendriveNativePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-zendrive-native'
  	project(':react-native-zendrive-native').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-zendrive-native/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-zendrive-native')
  	```


## Usage
```javascript
import ZendriveNative from 'react-native-zendrive-native';

// TODO: What to do with the module?
ZendriveNative;
```
