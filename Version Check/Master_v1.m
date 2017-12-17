clear all
global testetta testsigeps

ettablock = linspace(6.7,8.5,5);
sigepsblock = linspace(4,8.5,5);

testsigeps = 7;
for ii =1:5
    testetta = ettablock(ii);
    MTwoSec_test
    formatSpec = '1609etta %d.mat';
    name = sprintf(formatSpec,testetta);
    save(name)
end

testetta = 7.5;
for ii =1:5
    testsigeps = sigepsblock(ii);
    MTwoSec_test
    formatSpec = '1609sigeps %d.mat';
    name = sprintf(formatSpec,testsigeps);
    save(name)
end