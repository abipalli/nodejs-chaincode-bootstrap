// Straight Jasmine testing without Angular's testing support

import { Context } from 'fabric-contract-api';
import { ChaincodeStub, ClientIdentity } from 'fabric-shim';
import { FabCar } from './fabcar';
import { Car } from './car';

import * as chai from 'chai';
import * as chaiAsPromised from 'chai-as-promised';
import * as sinon from 'sinon';
import * as sinonChai from 'sinon-chai';
import winston = require('winston');

chai.should();
chai.use(chaiAsPromised);
chai.use(sinonChai);

class TestContext implements Context {
  public stub: sinon.SinonStubbedInstance<ChaincodeStub> = sinon.createStubInstance(ChaincodeStub);
  public clientIdentity: sinon.SinonStubbedInstance<ClientIdentity> = sinon.createStubInstance(ClientIdentity);
  public logging = {
    getLogger: sinon.stub().returns(sinon.createStubInstance(winston.createLogger().constructor)),
    setLevel: sinon.stub(),
  };
}

describe('FabCar Contract', () => {
  let contract: FabCar;
  let ctx: TestContext;
  
  beforeEach(() => {
    contract = new FabCar();
    ctx = new TestContext();
    ctx.stub.getState.withArgs('1001').resolves(Buffer.from('{"value":"my asset 1001 value"}'));
    ctx.stub.getState.withArgs('1002').resolves(Buffer.from('{"value":"my asset 1002 value"}'));
  });

  it('#initLedger should initalize all cars', () => {
    const cars: Car[] = [
      {
          color: 'blue',
          make: 'Toyota',
          model: 'Prius',
          owner: 'Tomoko',
      },
      {
          color: 'red',
          make: 'Ford',
          model: 'Mustang',
          owner: 'Brad',
      },
      {
          color: 'green',
          make: 'Hyundai',
          model: 'Tucson',
          owner: 'Jin Soo',
      },
      {
          color: 'yellow',
          make: 'Volkswagen',
          model: 'Passat',
          owner: 'Max',
      },
      {
          color: 'black',
          make: 'Tesla',
          model: 'S',
          owner: 'Adriana',
      },
      {
          color: 'purple',
          make: 'Peugeot',
          model: '205',
          owner: 'Michel',
      },
      {
          color: 'white',
          make: 'Chery',
          model: 'S22L',
          owner: 'Aarav',
      },
      {
          color: 'violet',
          make: 'Fiat',
          model: 'Punto',
          owner: 'Pari',
      },
      {
          color: 'indigo',
          make: 'Tata',
          model: 'Nano',
          owner: 'Valeria',
      },
      {
          color: 'brown',
          make: 'Holden',
          model: 'Barina',
          owner: 'Shotaro',
      },
    ];

    expect(service.getValue()).toBe('real value');
  });

  it('#getObservableValue should return value from observable',
    (done: DoneFn) => {
    service.getObservableValue().subscribe(value => {
      expect(value).toBe('observable value');
      done();
    });
  });

  it('#getPromiseValue should return value from a promise',
    (done: DoneFn) => {
    service.getPromiseValue().then(value => {
      expect(value).toBe('promise value');
      done();
    });
  });
});