import { Body, Controller, Post, Query } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { ApiBearerAuth, ApiOkResponse, ApiOperation, ApiTags, ApiBody } from '@nestjs/swagger';
import { CreateReportDto, ReportDto } from '../../@common/dto/report/report.dto';
import { LoggedInUser } from '../../@common/decorators/logged-in-user.decorator';
import { Roles } from '../../@common/decorators/roles.decorator';
import { Roles as RolesEnum } from '../../@common/enums/user.enum';

@ApiBearerAuth()
@Controller('api/v1/reports')
@ApiTags('Reports')
export class ReportsController {
    constructor(private readonly reportsService: ReportsService) {}

    @Post()
    @ApiOperation({ summary: 'Create a report' })
    @ApiOkResponse({ type: ReportDto, description: 'The newly created report' })
    createReport(/*@LoggedInUser('id') userID: number, */@Body() body: CreateReportDto): Promise<ReportDto> {
        return this.reportsService.createReport(body)
    }
}
