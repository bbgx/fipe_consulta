import axios from 'axios';

export const apiCars = axios.create({
    baseURL: 'https://parallelum.com.br/fipe/api/v1/carros'
});

export const apiBikes = axios.create({
  baseURL: 'https://parallelum.com.br/fipe/api/v1/motos'
});

export const apiTrucks = axios.create({
  baseURL: 'https://parallelum.com.br/fipe/api/v1/caminhoes'
});


export const GetAPI = (vehicleType: String) => {
  switch (vehicleType) {
    case 'car':
      return apiCars;
    case 'bike':
      return apiBikes;
    case 'truck':
      return apiTrucks;
  }
}