import { Injectable } from '@nestjs/common';
import { CreateReportDto, ReportDto } from '../../@common/dto/report/report.dto';
import { UserDto } from 'src/@common/dto/user/user.dto';
import { UsersRepoService } from '../repo/users-repo.service';
import { ReportRepoService } from '../../modules/repo/reports-repo.service';
import { Prisma } from '@prisma/client';
import { AuthService } from '../../modules/auth/auth.service';
import { DtoFactory } from '../../@common/utils/dto.utility';


@Injectable()
export class ReportsService {
    constructor(
        private readonly reportsRepo: ReportRepoService,
        private readonly authService: AuthService
    ) {}
    
    async createReport(reportCreateObj: CreateReportDto): Promise<ReportDto> {    
        const createPrisma: Prisma.ReportCreateInput = {
            data: reportCreateObj.data,
            type: reportCreateObj.type,
            category: reportCreateObj.category,
            message: reportCreateObj.message,
            //submitterID: ,
            submitter: {
                connect: {
                    id: this.authService.loggedInUser.id
                }
            },
        }

        const dbResponse = await this.reportsRepo.insert(createPrisma);

        return DtoFactory(ReportDto, dbResponse);
    }

}
