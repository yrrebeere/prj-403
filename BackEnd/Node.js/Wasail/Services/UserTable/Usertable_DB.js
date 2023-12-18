const db = require('../../models');

console.log("3");

async function UsernameExists(username){

    const user = await db.user_table.findOne({
        where : {username}
    });
    if(user) return user;

    return false;

}

async function CreateUser(args){
    const user = await db.user_table.create({
        phone_number: args.phone_number,
        name: args.name,
        password: args.password,
        user_name: args.user_name,
        language: args.language,
        user_type: args.user_type
    });
    console.log("4");
    return user;
}

module.exports = {
    UsernameExists,
    CreateUser
    console.log("4");
}