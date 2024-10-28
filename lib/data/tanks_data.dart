import 'package:plimsy/models/tank.dart';
import 'package:plimsy/models/tanks.dart';

final List<Tank> mockFuelTanks = [
  Tank(
    id: 'FuelTank1',
    maxCapacity: 10000.0,
    liters: 8500.0,
    prefix: 'FT',
    permeability: 0.95,
    weightSpec: 0.85,
  ),
  Tank(
    id: 'FuelTank2',
    maxCapacity: 12000.0,
    liters: 10000.0,
    prefix: 'FT',
    permeability: 0.97,
    weightSpec: 0.83,
  ),
];

final List<Tank> mockOilTanks = [
  Tank(
    id: 'OilTank1',
    maxCapacity: 8000.0,
    liters: 6000.0,
    prefix: 'OT',
    permeability: 0.88,
    weightSpec: 0.92,
  ),
  Tank(
    id: 'OilTank2',
    maxCapacity: 7500.0,
    liters: 5000.0,
    prefix: 'OT',
    permeability: 0.90,
    weightSpec: 0.91,
  ),
];

final List<Tank> mockFreshWaterTanks = [
  Tank(
    id: 'FreshWaterTank1',
    maxCapacity: 5000.0,
    liters: 4500.0,
    prefix: 'FWT',
    permeability: 0.99,
    weightSpec: 1.0,
  ),
  Tank(
    id: 'FreshWaterTank2',
    maxCapacity: 6000.0,
    liters: 5800.0,
    prefix: 'FWT',
    permeability: 0.98,
    weightSpec: 1.0,
  ),
];

final List<Tank> mockUreaTanks = [
  Tank(
    id: 'UreaTank1',
    maxCapacity: 3000.0,
    liters: 2500.0,
    prefix: 'UT',
    permeability: 0.94,
    weightSpec: 0.88,
  ),
];

final List<Tank> mockPoolTanks = [
  Tank(
    id: 'PoolTank1',
    maxCapacity: 4000.0,
    liters: 3500.0,
    prefix: 'PT',
    permeability: 0.96,
    weightSpec: 0.99,
  ),
];

final List<Tank> mockSewageTanks = [
  Tank(
    id: 'SewageTank1',
    maxCapacity: 2500.0,
    liters: 2000.0,
    prefix: 'ST',
    permeability: 0.92,
    weightSpec: 0.95,
  ),
  Tank(
    id: 'SewageTank2',
    maxCapacity: 2700.0,
    liters: 2300.0,
    prefix: 'ST',
    permeability: 0.93,
    weightSpec: 0.94,
  ),
];

final Tanks mockTanks = Tanks(
  mockFuelTanks, // Lista di fuel tanks
  mockOilTanks, // Lista di oil tanks
  mockFreshWaterTanks, // Lista di fresh water tanks
  mockUreaTanks, // Lista di urea tanks
  mockPoolTanks, // Lista di pool tanks
  mockSewageTanks, // Lista di sewage tanks
);
