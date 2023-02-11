import { Text, TouchableOpacity, View, FlatList, Alert } from 'react-native';
import DropDownPicker from 'react-native-dropdown-picker';
import { Feather } from '@expo/vector-icons'; 
import { useEffect, useState } from 'react';
import { GetAPI } from '../../services/api/fipe';
import { IBrand } from '../../Interfaces/IBrand';
import Dropdown from '../../components/Dropdown';
import { IModel } from '../../Interfaces/IModel';
import { IYear } from '../../Interfaces/IYear';
import { IFipe } from '../../Interfaces/IFipe';

export default function Fipe() {
  const [isOpenVehicleType, setIsOpenVehicleType] = useState(false);
  const [selectedVehicleType, setSelectedVehicleType] = useState(null);
  
  const [isOpenVehicleBrand, setIsOpenVehicleBrand] = useState(false);
  const [selectedVehicleBrand, setSelectedVehicleBrand] = useState(null);
  
  const [isOpenVehicleModel, setIsOpenVehicleModel] = useState(false);
  const [selectedVehicleModel, setSelectedVehicleModel] = useState(null);
  
  const [isOpenVehicleYear, setIsOpenVehicleYear] = useState(false);
  const [selectedVehicleYear, setSelectedVehicleYear] = useState(null);


  const [vehicleBrand, setVehicleBrand] = useState<Array<IBrand>>();
  const [vehicleModel, setVehicleModel] = useState<Array<IModel>>();
  const [vehicleYear, setVehicleYear] = useState<Array<IYear>>();

  const [fipe, setFipe] = useState<IFipe | null>(null);

  const vehicleTypes = [
    {label: 'Car', value: 'car'},
    {label: 'Bike', value: 'bike'},
    {label: 'Truck', value: 'truck'}
  ];
  

  function searchFipe(){
    if(selectedVehicleType && selectedVehicleBrand && selectedVehicleModel){
      var fipeAPI = GetAPI(selectedVehicleType);
      console.log(`/marcas/${selectedVehicleBrand}/modelos/${selectedVehicleModel}/anos/${selectedVehicleYear}`);
      fipeAPI?.get(`/marcas/${selectedVehicleBrand}/modelos/${selectedVehicleModel}/anos/${selectedVehicleYear}`)
        .then((response) => {
          setFipe(response.data);
          console.log(response.data);
        })
    }
  }

  function searchBrand(){
    if(selectedVehicleType){
      var fipeAPI = GetAPI(selectedVehicleType);
      fipeAPI?.get('/marcas')
        .then((response) => {
          setVehicleBrand(response.data.map((item:any) => ({Name: item.nome, Code: item.codigo})));
        })
    }
  }

  function searchModel(){
    if(selectedVehicleType && selectedVehicleBrand){
      var fipeAPI = GetAPI(selectedVehicleType);
      fipeAPI?.get(`/marcas/${selectedVehicleBrand}/modelos`)
        .then((response) => {
          setVehicleModel(response.data.modelos.map((item:any) => ({Name: item.nome, Code: item.codigo})));
        })
    }
  }

  function searchYear(){
    if(selectedVehicleType && selectedVehicleBrand && selectedVehicleModel){
      var fipeAPI = GetAPI(selectedVehicleType);
      fipeAPI?.get(`/marcas/${selectedVehicleBrand}/modelos/${selectedVehicleModel}/anos`)
        .then((response) => {
          setVehicleYear(response.data.map((item:any) => ({Name: item.nome, Code: item.codigo})));
        })
    }
  }

  useEffect(() => {
    setSelectedVehicleYear(null);
    setSelectedVehicleModel(null);
    setSelectedVehicleBrand(null);
    searchBrand();
  }, [selectedVehicleType])

  useEffect(() => {
    setSelectedVehicleYear(null);
    setSelectedVehicleModel(null);
    searchModel();
  }, [selectedVehicleBrand])

  useEffect(() => {
    setSelectedVehicleYear(null);
    searchYear();
  }, [selectedVehicleModel])

  return (
    <View className='flex-1  justify-center items-center '>
      <Dropdown
        label={"Select type of vehicle"}
        disabled={false}
        isOpen={isOpenVehicleType}
        value={selectedVehicleType}
        setValue={(value:any) => setSelectedVehicleType(value)}
        items={vehicleTypes}
        setOpen={() => setIsOpenVehicleType(!isOpenVehicleType)}
      />
      <Dropdown
        disabled={!selectedVehicleType}
        label={"Select brand"}
        isOpen={isOpenVehicleBrand}
        value={selectedVehicleBrand}
        setValue={(value:any) => setSelectedVehicleBrand(value)}
        items={!vehicleBrand ? [] : vehicleBrand.map(model => ({label: model.Name, value: model.Code}))}
        setOpen={() => setIsOpenVehicleBrand(!isOpenVehicleBrand)}
      />
      <Dropdown
        disabled={!selectedVehicleBrand}
        label={"Select model"}
        isOpen={isOpenVehicleModel}
        value={selectedVehicleModel}
        setValue={(value:any) => setSelectedVehicleModel(value)}
        items={!vehicleModel ? [] : vehicleModel.map(model => ({label: model.Name, value: model.Code}))}
        setOpen={() => setIsOpenVehicleModel(!isOpenVehicleModel)}
      />
      <Dropdown
        disabled={!selectedVehicleModel}
        label={"Select year"}
        isOpen={isOpenVehicleYear}
        value={selectedVehicleYear}
        setValue={(value:any) => setSelectedVehicleYear(value)}
        items={!vehicleYear ? [] : vehicleYear.map(model => ({label: model.Name, value: model.Code}))}
        setOpen={() => setIsOpenVehicleYear(!isOpenVehicleYear)}
      />
      <TouchableOpacity 
        activeOpacity={0.7}
        className='flex-row h-11 px-4 border border-black mt-2 rounded-lg items-center'
        onPress={searchFipe}
      >
        <Feather name="search"/>
        <Text>Search</Text>
      </TouchableOpacity>
    </View>
  );
}