// noinspection DuplicatedCode

import * as request from 'supertest';
import { ReportType, ReportCategory } from '../src/@common/enums/report.enum';
import { PrismaService } from '../src/modules/repo/prisma.service';
import { AuthService } from '../src/modules/auth/auth.service';
import { Roles } from '../src/@common/enums/user.enum';
import { ReportDto } from '../src/@common/dto/report/report.dto';
import { MapType } from '../src/@common/enums/map.enum';
import { post } from './testutil';

describe('reports', () => {
    let user1, user2, user2Token, testMap, report;

    beforeEach(async () => {
        const prisma: PrismaService = global.prisma;

        user1 = await prisma.user.create({
            data: {
                steamID: '123123123',
                alias: 'Normal User',
                roles: Roles.VERIFIED,
            }
        });

        user2 = await prisma.user.create({
            data: {
                steamID: '12312334343',
                alias: 'Suspect',
                roles: Roles.VERIFIED,
            }
        });

        testMap = await prisma.map.create({
            data: {
                name: 'surf_badabingbadaboom',
                type: MapType.SURF,
                submitterID: user2.id
            }
        });

        
        // report = await prisma.report.create({
        //     data: {
        //         data: testMap.id.toString(),
        //         message: "I created this map :(",
        //         type: ReportType.MAP_REPORT,
        //         category: ReportCategory.PLAGIARSIM,
        //         resolved: false,
        //         submitterID: user1.id,
        //     }
        // });

        const authService = global.auth as AuthService;
        global.accessToken = (await authService.login(user1)).access_token;
        user2Token = (await authService.login(user2)).access_token;
    });

    afterEach(async () => {
        const prisma: PrismaService = global.prisma;

        await prisma.user.deleteMany({ where: { id: { in: [user1.id, user2.id] } } });
        await prisma.map.deleteMany({ where: { id: { in: [testMap.id] } } });
        await prisma.report.deleteMany({ where: { id: { in: [report.id] } } });
    });

    describe('POST /api/v1/reports', () => {
        it('should create a new report', async () => {

            const res = await post('reports', 201, {
                data: testMap.id.toString(),
                message: "I created this map :(",
                type: ReportType.MAP_REPORT,
                category: ReportCategory.PLAGIARISM,
                resolved: false,
                submitterID: user1.id,
            });
            console.log(res.body);
            expect(res.body).toBeValidDto(ReportDto);
            // await request(global.server)
            //     .post('reports')
            //     .send({
            //         data: testMap.id.toString(),
            //         message: "I created this map :(",
            //         type: ReportType.MAP_REPORT,
            //         category: ReportCategory.PLAGIARISM,
            //         resolved: false,
            //         submitterID: user1.id,
            //     })
            //     .expect(200);
        });
    });

    //beforeAll(() => {
        // return forceSyncDB().then(() => {
        //     return auth.genAccessToken(testUser);
        // }).then((token) => {
        //     accessToken = token;
        //     return User.create(testUser);
        // }).then(() => {
        //     testAdmin.roles |= Roles.ADMIN;
        //     return auth.genAccessToken(testAdmin);
        // }).then((token) => {
        //     adminAccessToken = token;
        //     return User.create(testAdmin);
        // }).then(() => {
        //     testAdminGame.roles |= Roles.ADMIN;
        //     return auth.genAccessToken(testAdminGame, true);
        // }).then((token) => {
        //     adminGameAccessToken = token;
        //     return User.create(testAdminGame);
        // }).then(user => {
        //     return Map.create(testMap, {
        //         include: [
        //             {  model: MapInfo, as: 'info',},
        //             {  model: MapCredit, as: 'credits'}
        //         ],
        //     });
        // });
    //});

    //describe('endpoints', () => {
        //
        // describe('POST /api/reports', () => {
        //     it('should create a new report', () => {
        //         return chai.request(server)
        //             .post('/api/reports')
        //             .set('Authorization', 'Bearer ' + accessToken)
        //             .send({
        //                 data: testMap.id.toString(),
        //                 type: report.ReportType.MAP_REPORT,
        //                 category: report.ReportCategory.PLAGIARSIM,
        //                 message: 'I created this map :(',
        //             })
        //         .then(res => {
        //             expect(res).to.have.status(200);
        //             expect(res).to.be.json;
        //             expect(res.body).toHaveProperty('id');
        //         });
        //     });
        // });
    //});
});
