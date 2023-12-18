const {expect} = require('chai');
const {UsernameExists,CreateUser} = require('../../Services/UserTable/Usertable_DB');

console.log("5");

describe('User Table Test Suite',() => {
    it('should see if a username already exists in the database',async () => {

        const check = await UsernameExists('asdfghjkl');
        expect(check).to.be.false;
        expect(check === undefined).to.be.false;
        expect(check === null).to.be.false;

    })
    it('should create a new user', async () => {
        const phone_number = '03244565443';
        const name = 'test';
        const password = 'test';
        const user_name = 'test';
        const language = 'Urdu';
        const user_type = 'Vendor';

        const args = {phone_number, name, password, user_name, language, user_type};
        const user = await CreateUser(args);
        expect(user).to.be.an('object');
        expect(user.phone_number).to.equal(phone_number);
        expect(user.name).to.equal(name);
        expect(user.password).to.equal(password);
        expect(user.user_name).to.equal(user_name);
        expect(user.language).to.equal(language);
        expect(user.user_type).to.equal(user_type);

    })
})

// async function CreateDummyUser(){
//     return await db.user_table.create({
//         phone_number : 'test',
//         name : 'test',
//         password : 'test',
//         user_name : 'test',
//         language : 'test',
//         user_type : 'test',
//     })
// }